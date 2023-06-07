# Graphics-Engine-Final-Delivery
## By Alejandro Avila Rodriguez & Bosco Barber Esbert
In this final delivery we have implemented a Multipass Bloom shader with HDR and a Water Shader effect:
### Normal Scene With deferred Shading:
![Normal deferred rendered scene](https://github.com/boscobarberesbert/Graphics-Engine-Final-Delivery/assets/46872250/589dadb4-ef84-49d0-ae94-142be5ffbf96)
### Scene After Bloom + HDR:
![Merge](https://github.com/boscobarberesbert/Graphics-Engine-Final-Delivery/assets/46872250/3246649f-9aaa-4280-8f1d-016db42675a0)
### Scene With Water Plane + Bloom + HDR:
![Water Shader](https://github.com/boscobarberesbert/Graphics-Engine-Final-Delivery/assets/46872250/4a540ddd-5f8b-4724-b6f4-f8271e19efcc)

To change between bloom and water shader you can click a checkbox under view->effects. 
![Checkbox](https://github.com/boscobarberesbert/Graphics-Engine-Final-Delivery/assets/46872250/339a9690-6009-42fb-9290-c3a8e85b4954)

For the bloom effect the shader files are:
- g_buffer.glsl
- deferred_shading.glsl
- gaussian_blur.glsl
- bloom_shader.glsl
- light_source.glsl
For the water shader the files are:
- reflection.glsl
- refraction.glsl
- water.glsl


