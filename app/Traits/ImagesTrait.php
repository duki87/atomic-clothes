<?php
  namespace App\Traits;
  use Image;
  use Illuminate\Http\Request;
  use Carbon\Carbon;
  use Illuminate\Support\Str;
  use Illuminate\Support\Facades\Storage;

  trait ImagesTrait
  {
    public function validateBrandLogo(Request $request)
    {
        $this->validate($request, [
            'image' => 'mimes:jpeg,jpg,png,gif|max:2000' // max 10000kb
        ]);           
    }

    public static function uploadConstraintImage($image, $ratio, $saveFormat, $folder) 
    {
        $img = Image::make($image);
        // resize the image to a width of 300 and constrain aspect ratio (auto height)
        $img->resize($ratio, null, function ($constraint) {
            $constraint->aspectRatio();
        });
        $imgTitle = Str::random(32).'.'.$saveFormat;
        if($img->save($folder.'/'.$imgTitle)) {
            return $imgTitle;
        }     
    }

    public static function deleteImage($folder, $image) 
    {
        Storage::disk('images')->delete($folder . '/' . $image);
    }

  }

?>
