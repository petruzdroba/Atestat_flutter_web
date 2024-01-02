from django.contrib import admin
from .models import TestModel, PopularProductModel, DetailedProductModel, CustomUser

admin.site.register(TestModel)
admin.site.register(PopularProductModel)
admin.site.register(DetailedProductModel)
admin.site.register(CustomUser)