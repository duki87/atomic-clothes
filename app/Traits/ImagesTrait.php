<?php
  namespace App\Traits;
  use Image;
  use Illuminate\Http\Request;
  use Carbon\Carbon;
  use Illuminate\Support\Str;

  trait ImagesTrait
  {
    public function validateImage(Request $request)
    {
        $this->validate($request, [
            'image' => 'mimes:jpeg,jpg,png,gif|max:2000' // max 10000kb
        ]);           
    }

    public static function uploadBrandLogo($logo) 
    {
        $img = Image::make($logo);
        // resize the image to a width of 300 and constrain aspect ratio (auto height)
        $img->resize(300, null, function ($constraint) {
            $constraint->aspectRatio();
        });
        //dd(Carbon::now());
        $imgTitle = Str::random(32).'.png';
        if($img->save('images/brandLogos/'.$imgTitle)) {
            return $imgTitle;
        }     
    }

  }

?>
