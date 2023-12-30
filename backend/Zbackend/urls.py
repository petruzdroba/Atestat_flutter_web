from django.urls import path
from django.contrib import admin
from web_backend import views as web_views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('get_string/', web_views.get_string, name='get_string'),
    path('getProductById/<int:id>/', web_views.getProductById, name = 'getProductById'),
    path('getPopularProduct/', web_views.getPopularProduct, name='getPopularProduct')
    # Add any other URL patterns as needed
]