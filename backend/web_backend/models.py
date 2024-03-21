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
    name = models.CharField(max_length=255, unique = True)
    price = models.FloatField()
    product_id = models.IntegerField(primary_key = True)
    image = models.CharField(max_length=255)
    description = models.TextField()
    author = models.CharField(max_length=255)
    images = models.JSONField()

    @classmethod
    def does_exist(cls, product_id):
        try:
            cls.objects.get(product_id=product_id)
            return True
        except cls.DoesNotExist:
            return False

    def __str__(self):
        return self.name

class CustomUser(models.Model):
    name = models.CharField(max_length=255)
    username = models.CharField(max_length=255, unique=True, primary_key=True)
    password = models.CharField(max_length=255)
    pfp = models.CharField(max_length=255, default='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0Gru9G3h6HXfS6f2F9S0gTm49NAyDwU2jiQ&usqp=CAU')
    created_products = models.JSONField(blank = True, null = True)

    def add_product(self, product_id):
        if self.created_products is None:
            self.created_products = []

        self.created_products.append(int(product_id))
        self.save()

    def remove_product(self, product_id):
        if self.created_products is None:
            self.created_products = []

        self.created_products.remove(int(product_id))
        self.save()

    def __str__(self):
        return self.username

class UserLists(models.Model):
    username = models.CharField(max_length=255, unique=True, primary_key=True)
    favorite = models.JSONField(blank = True, null = True)
    friends = models.JSONField(blank = True, null = True)
    cart = models.JSONField(blank = True, null = True)

    @classmethod
    def get_user_by_username(cls, username):
        try:
            return cls.objects.get(username=username)
        except cls.DoesNotExist:
            return None

    def add_favorite(self, product_id):
        if self.favorite is None:
            self.favorite = []
        self.favorite.append(int(product_id))
        self.save()

    def remove_favorite(self, product_id):
        if self.favorite is None:
            self.favorite = []
        self.favorite.remove(int(product_id))
        self.save()

    def add_friends(self, username):
        if self.friends is None:
            self.friends = []
        self.friends.append(CharField(username))
        self.save()

    def remove_friends(self, username):
        if self.friends is None:
            self.friends = []
        self.friends.remove(CharField(username))
        self.save()

    def __str__(self):
        return self.username