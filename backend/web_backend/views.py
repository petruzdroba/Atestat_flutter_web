from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
import json
from .models import TestModel, PopularProductModel

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