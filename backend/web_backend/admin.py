from django.contrib import admin
from .models import TestModel, PopularProductModel, DetailedProductModel

admin.site.register(TestModel)
admin.site.register(PopularProductModel)
admin.site.register(DetailedProductModel)