from rest_framework import serializers
from .models import CustomUser

class CustomUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = ['name', 'username', 'password']

    def _is_valid(self, data):
        # Check if the username is unique
        existing_user = CustomUser.objects.filter(username=data['username']).first()
        if existing_user and existing_user != self.instance:
            raise serializers.ValidationError({'username': 'This username is already in use.'})

    def validate(self, data):
        # Validate the uniqueness of the username
        self._is_valid(data)
        
        # Add additional validation logic if needed
        
        return data
