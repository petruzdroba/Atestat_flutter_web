from django.db import models

# Create your models here.
class TestModel(models.Model):
	my_string = models.CharField(max_length = 255)

class PopularProductModel(models.Model):
    name = models.CharField(max_length=50)
    product_id = models.IntegerField()  
    price = models.FloatField()  
    author = models.CharField(max_length=150)
    gif = models.CharField(max_length=255)

class DetailedProductModel(models.Model):
    name = models.CharField(max_length=255)
    price = models.FloatField()
    product_id = models.IntegerField(primary_key = True)
    image = models.CharField(max_length=255)
    description = models.TextField()
    list_data = models.JSONField()  # Assuming 'list' is a JSON array in the original JSON
    author = models.CharField(max_length=255)
    images = models.JSONField()  # Assuming 'images' is a JSON array in the original JSON

    def __str__(self):
        return self.name

class CustomUser(models.Model):
    name = models.CharField(max_length=255)
    username = models.CharField(max_length=255, unique=True, primary_key = True)
    password = models.CharField(max_length=255)

    def __str__(self):
        return self.username