from django.urls import path
from django.contrib import admin
from web_backend import views as web_views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('get_string/', web_views.get_string, name='get_string'),
    path('getProductById/<int:id>/', web_views.getProductById, name = 'getProductById'),
    path('getPopularProduct/', web_views.getPopularProduct, name='getPopularProduct'),
    path('getAllProducts/', web_views.getAllProducts, name='getAllProducts'),
    path('getUserByUsername/<str:input_username>/', web_views.getUserByUsername, name = 'getUserByUsername'),
    path('UserRegistrationView/', web_views.UserRegistrationView.as_view(), name = 'UserRegistrationView'),
    path('UserLoginView/', web_views.UserLoginView.as_view(), name = 'UserLoginView'),
    path('DeleteUserAccount/', web_views.DeleteUserAccount.as_view(), name = 'DeleteUserAccount'),
    # Add any other URL patterns as needed
]