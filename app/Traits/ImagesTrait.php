<?php
  namespace App\Traits;
  use Image;
  use Illuminate\Http\Request;
  use Carbon\Carbon;
  use Illuminate\Support\Str;
  use Illuminate\Support\Facades\Storage;
  use App\Product;
  use App\ProductImages;

  trait ImagesTrait
  {
    public function validateBrandLogo(Request $request)
    {
        $this->validate($request, [
            'image' => 'mimes:jpeg,jpg,png,gif|max:2000' 
        ]);           
    }

    public function validateProductImage(Request $request)
    {
        $this->validate($request, [
            'image' => 'mimes:jpeg,jpg,png,gif|max:5000' 
        ]);           
    }

    public function uploadProductImages(Request $request)
    {
        $this->validate($request, [
            'images.*' => 'mimes:jpeg,png,jpg|max:5000'
        ]);
        $images = [];
        if($request->has('directory')) {
            $directory = $request->directory;
        } else {
            $directory = strtolower(Carbon::now()->format('dmYHis').'-'.Str::random(16));
        }     
        foreach($request->file('images') as $image) {
            $imageName = self::uploadConstraintImage($image, 1024, 'jpg', 'products/'.$directory);           
            $productImage = new ProductImages([
                'product_id' => $request->product_id,
                'image'      => $imageName
            ]);
            if($productImage->save()) {
                $image = [];
                $image['id'] = $productImage->id;
                $image['name'] = $imageName;
                $images[] = $image;
            }             
        }
        return ['images' => $images, 'directory' => $directory];         
    }

    public function destroyProductImage($id)
    {
        $image = ProductImages::where(['id' => $id])->with('product')->first();       
        $name = $image['image'];
        $folder = $image->product['image_folder'];
        self::deleteImage('products/'.$folder, $name);
        $image->delete();
    }

    public function destroyProductImages($id)
    {
        $product = Product::where(['id' => $id])->with('product_images')->first();
        if($product->product_images) {
            foreach($product->product_images as $image) {
                self::deleteImage('products/'.$product->image_folder, $image['image']);
                ProductImages::where(['id' => $image['id']])->delete();
            }
        }
    }

    public static function uploadConstraintImage($image, $ratio, $saveFormat, $folder) 
    {
        $img = Image::make($image);
        // resize the image to a width of $ratio and constrain aspect ratio (auto height)
        $img->resize($ratio, null, function ($constraint) {
            $constraint->aspectRatio();
        });
        $imgTitle = Str::random(32).'.'.$saveFormat;
        if(!Storage::disk('images')->has($folder)) {
            Storage::disk('images')->makeDirectory($folder);
        }
        if($img->save('images/'.$folder.'/'.$imgTitle)) {
            return $imgTitle;
        }     
    }

    public static function deleteImage($folder, $image) 
    {
        Storage::disk('images')->delete($folder . '/' . $image);
    }

  }

?>
