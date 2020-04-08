<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Traits\ManualPaginationTrait;
use App\PromoCode;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\ValidationException;

class PromoCodeController extends Controller
{
    use ManualPaginationTrait;

    public function index()
    {
        $promoCodes = PromoCode::get();
        $promoCodes = $promoCodes->groupBy('coupon_series');
        $promoCodes = self::paginate($promoCodes, $promoCodes->count(), 5);
        return response(['promo_codes' => $promoCodes], 200);
    }

    public function store(Request $request)
    {
        if(!$request->number_of_codes) {
            $validator = Validator::make([], []); // Empty data and rules fields
            $validator->errors()->add('error', 'Please enter number of codes to create.');
            throw new ValidationException($validator);
        }
        $request->start = date('y-m-d H:i:s', strtotime($request->start));        
        $request->expire = date('y-m-d H:i:s', strtotime($request->expire));
        $coupon_series = $this->generateCode();
        $this->validate($request, [
            'number_of_codes' => 'required|integer',
            'start' => 'required|date:Y-m-d H:i:s|after:today',
            'expire' => 'required|date:Y-m-d H:i:s|after:start',
            'discount' => 'required|integer|', //must be 1-100
        ]);
        for($i=1; $i<=$request->number_of_codes; $i++) {
            $promoCode = new PromoCode();
            $promoCode->start = $request->start;
            $promoCode->expire = $request->expire;
            $promoCode->category_id = $request->category_id;
            $promoCode->brand_id = $request->brand_id;
            $promoCode->discount = $request->discount;
            $promoCode->coupon_series = $coupon_series;
            $promoCode->coupon_no = $i;
            $promoCode->status = 1;
            $promoCode->save();
        } 
        return response(['CREATED'], 201);
    }

    public function show($id)
    {
        
    }

    public function destroy()
    {
        
    }

    private function generateCode() 
    {
        $randomNumbers = strtoupper(Str::random(4)) . sprintf("%06s", mt_rand(10,100000));
        return $randomNumbers;
    }
}
