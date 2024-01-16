import json
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.core import serializers
from django.core.serializers.json import DjangoJSONEncoder
from django.contrib.auth.hashers import make_password, check_password
from django.db import IntegrityError
from django.db.models import Max
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .models import TestModel, PopularProductModel, DetailedProductModel, CustomUser, UserLists
from .serializers import CustomUserSerializer, DetailedProductSerializer, UserListSerializer


@csrf_exempt  
def get_string(request):
    try:
        my_model_instance = TestModel.objects.get(pk=1)  # Adjust the query as needed
        my_string = my_model_instance.my_string
        return JsonResponse({'message': my_string})
    except TestModel.DoesNotExist:
        return JsonResponse({'message': 'String not found'}, status=404)

@csrf_exempt
def getPopularProduct(request):
    try:
        popular_product = PopularProductModel.objects.get(pk=1)
        response_data = {
            'name': popular_product.name,
            'id': popular_product.product_id,
            'price': popular_product.price,
            'author': popular_product.author,
            'gif': popular_product.gif
        }
        return JsonResponse(response_data)
    except PopularProductModel.DoesNotExist:
        return JsonResponse({'message': 'Popular product not found'}, status=404)

class CustomJSONEncoder(DjangoJSONEncoder):
    def default(self, obj):
        if isinstance(obj, DetailedProductModel):
            return {
                'id': obj.product_id,
                'name': obj.name,
                'price': obj.price,
                'description': obj.description,
                'image':obj.image,
                'author': obj.author,
            }
        return super().default(obj)

@csrf_exempt
def getAllProducts(request):
    try:
        # Query all instances of DetailedProductModel
        all_products = DetailedProductModel.objects.all()

        # Serialize the queryset using the custom JSON encoder
        serialized_products = json.dumps(list(all_products), cls=CustomJSONEncoder)

        # Return the serialized data as JSON response
        return JsonResponse(json.loads(serialized_products), safe=False)
    except DetailedProductModel.DoesNotExist:
        return JsonResponse({'message': 'No products found'}, status=404)

def getProductById(request, id):
    try:
        product = DetailedProductModel.objects.get(product_id = id)
        response_data = {
        'name' : product.name,
        'price':product.price,
        'id':product.product_id,
        'image':product.image,
        'description':product.description,
        'author':product.author,
        'images':product.images
        }
        return JsonResponse(response_data)
    except DetailedProductModel.DoesNotExist:
        return JsonResponse({'message': 'Product not found'}, status=404)

class ProductSellView(APIView):
    def post(self, request):
        data_from_frontend = request.data

        try:

            max_product_id = DetailedProductModel.objects.all().aggregate(Max('product_id'))['product_id__max']
            new_product_id = max_product_id + 1 if max_product_id is not None else 1

            new_product = DetailedProductModel.objects.create(
                name = data_from_frontend.get('name'),
                price = data_from_frontend.get('price'),
                product_id = new_product_id,
                image = data_from_frontend.get('image'),
                description = data_from_frontend.get('description'),
                author = data_from_frontend.get('author'),
                images = data_from_frontend.get('images')
                )
            serializer = DetailedProductSerializer(new_product)
            response_data = {'id': new_product.product_id, **serializer.data}
            return Response(response_data, status=status.HTTP_201_CREATED)
        except IntegrityError as e:
            return Response({'detail': 'Product already exists'}, status=status.HTTP_400_BAD_REQUEST)

class AddProductIdView(APIView):
    def post(self, request):
        data_from_frontend = request.data
        try:
            user = CustomUser.objects.get(username=data_from_frontend.get('username'))
        except CustomUser.DoesNotExist:
            return JsonResponse({'message': 'User not found'}, status=404)

        product_id = data_from_frontend.get('product_id')

        if product_id is not None:
            try:
                user.add_product(product_id)
                return JsonResponse({'message': f'Product ID {product_id} added to user {user.username}'}, status=201)
            except DetailedProductModel.DoesNotExist:
                return JsonResponse({'message': 'Product not found'}, status=404)
        else:
            return JsonResponse({'message': 'Product ID not provided'}, status=400)

class RemoveProductIdView(APIView):
    def post(self, request):
        data_from_frontend = request.data
        try:
            user = CustomUser.objects.get(username=data_from_frontend.get('username'))
        except CustomUser.DoesNotExist:
            return JsonResponse({'message': 'User not found'}, status=404)

        product_id = data_from_frontend.get('product_id')

        if product_id is not None:
            try:
                user.remove_product(product_id)
                return JsonResponse({'message': f'Product ID {product_id} removed from user {user.username}'}, status=200)
            except DetailedProductModel.DoesNotExist:
                return JsonResponse({'message': 'Product not found in user\'s list'}, status=404)
        else:
            return JsonResponse({'message': 'Product ID not provided'}, status=400)

class AddFavoriteProduct(APIView):
    def post(self,request):
        data_from_frontend = request.data

        try:
            user = UserLists.objects.get(username=data_from_frontend.get('username'))
        except CustomUser.DoesNotExist:
            return JsonResponse({'message': 'User not found'}, status=404)

        product_id = data_from_frontend.get('product_id')

        if DetailedProductModel.does_exist(product_id) and product_id is not None:
            try:
                user.add_favorite(product_id)
                return Json({'message':'product added'}, status = 200)
            except DetailedProductModel.DoesNotExist:
                return JsonResponse({'message': 'Product not found in user\'s list'}, status=404) 
        else:
            return JsonResponse({'message': 'Product ID not provided'}, status=400)



def getUserByUsername(request, input_username):
    try:
        user = CustomUser.objects.get(username=input_username)
        
        created_products = user.created_products or []
        created_product_ids = list(map(int, created_products))

        response_data = {
            'name': user.name,
            'username': user.username,
            'pfp': user.pfp,
            'created_products': created_product_ids
        }
        return JsonResponse(response_data)
    except CustomUser.DoesNotExist:
        return JsonResponse({'message': 'User not found'}, status=404)

class UserRegistrationView(APIView):
    def post(self, request):
        data_from_frontend = request.data

        hashed_password = make_password(data_from_frontend.get('password'))

        data_from_frontend['password'] = hashed_password

        try:
            new_user = CustomUser.objects.create(
                name=data_from_frontend.get('name'),
                username=data_from_frontend.get('username'),
                password=hashed_password,
                pfp='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0Gru9G3h6HXfS6f2F9S0gTm49NAyDwU2jiQ&usqp=CAU',
            )

            user_list = UserLists.objects.create(
                username = data_from_frontend.get('username')
            )

            serializer = CustomUserSerializer(new_user)
            return Response(serializer.data, status=status.HTTP_201_CREATED)

        except IntegrityError as e:
            return Response({'detail': 'Username already exists'}, status=status.HTTP_400_BAD_REQUEST)

class UserLoginView(APIView):
    def post(self,request):
        data_from_frontend = request.data
        try:

            user = CustomUser.objects.get(username=data_from_frontend.get('username'))

            entered_password = data_from_frontend.get('password')

            if check_password(entered_password, user.password):
                serializer = CustomUserSerializer(user)

                return Response(serializer.data, status=status.HTTP_200_OK)
            else: 
                return Response({'detail': 'Invalid credentials'}, status=status.HTTP_401_UNAUTHORIZED)
        except CustomUser.DoesNotExist:
            return Response({'detail': 'User does not exist'}, status=status.HTTP_404_NOT_FOUND)

class DeleteUserAccount(APIView):
    def post(self,request):
        data_from_frontend = request.data
        try:
            user = CustomUser.objects.get(username=data_from_frontend.get('username'))

            entered_password = data_from_frontend.get('password')

            if check_password(entered_password, user.password):

                for product_id in user.created_products:
                    try:
                        product = DetailedProductModel.objects.get(product_id=product_id)
                        product.delete()
                    except DetailedProductModel.DoesNotExist:
                        pass  # Product not found, move on

                user.delete()
                return Response({"message": "Account deleted successfully"}, status=status.HTTP_200_OK)
            else:
                return Response({"error": "Incorrect password"}, status=status.HTTP_401_UNAUTHORIZED)
        except:
            return Response({"error": "User not found"}, status=status.HTTP_404_NOT_FOUND)

class DeleteProduct(APIView):
    def post(self, request):
        data_from_frontend = request.data
        try:
            product = DetailedProductModel.objects.get(product_id = data_from_frontend.get('product_id'))

            product.delete();
            return Response({"message": "Product deleted successfully"}, status=status.HTTP_200_OK)
        except:
            return JsonResponse({'message': 'Product not found'}, status=404)

class EditUser(APIView):
    def put(self, request):
        check_username = request.data.get('checkUsername')

        try:
            user = CustomUser.objects.get(username=check_username)

            # Update the fields based on the data from the request
            user.name = request.data.get('name', user.name)
            user.username = request.data.get('username', user.username)
            user.pfp = request.data.get('pfp', user.pfp)

            user.save()
            return Response({"message": "User updated successfully"}, status=status.HTTP_200_OK)
        except CustomUser.DoesNotExist:
            return JsonResponse({'message': 'User not found'}, status=404)
        except Exception as e:
            return JsonResponse({'message': f'An error occurred: {str(e)}'}, status=500)




