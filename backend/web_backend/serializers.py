from rest_framework import serializers
from .models import CustomUser, DetailedProductModel

class CustomUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = ['name', 'username', 'password', 'pfp', 'created_products']

    def get_created_products_id(self, obj):
        return list(obj.created_products_id.values_list('username', flat=True))
    
    def _is_valid(self, data):
        existing_user = CustomUser.objects.filter(username=data['username']).first()
        if existing_user and existing_user != self.instance:
            raise serializers.ValidationError({'username': 'This username is already in use.'})

    def validate(self, data):
        self._is_valid(data)        
        return data

class DetailedProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = DetailedProductModel
        fields = ['name', 'price', 'product_id', 'image', 'description', 'author', 'images']

    def _is_valid(self, data):
        name = data.get('name')
        if name:
            existing_product = DetailedProductModel.objects.filter(name=name)
            if self.instance:
                existing_product = existing_product.exclude(product_id=self.instance.product_id)
            if existing_product.exists():
                raise serializers.ValidationError({'name': 'Product with this name already exists.'})

    def validate(self, data):
        self._is_valid(data)
        return data
