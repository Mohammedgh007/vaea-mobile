
import 'package:vaea_mobile/data/enums/city_name.dart';
import 'package:vaea_mobile/data/enums/district_enum.dart';
import 'package:vaea_mobile/data/enums/home_type.dart';

import '../enums/gender.dart';

/// It stores the fields of the query rest api request that is sent
/// for searching for available housing units.
class HomeSearchDto {

  // They are optional fields except pager
  HomeType? homeType;
  CityName? cityName;
  DistrictEnum? district;
  int? bedrooms;
  int? bathrooms;
  Gender? gender;
  int sortingOption;
  /// it starts from 0 and increments by 1
  int pager;

  HomeSearchDto(
      {this.homeType,
      this.cityName,
      this.district,
      this.bedrooms,
      this.bathrooms,
      this.gender,
      required this.sortingOption,
      required this.pager
      });

  /// It is used to convert the fields to map in order to be converted as a json object.
  Map<String, dynamic> getFieldMap() {
    return {
      "unit_type": (homeType == null) ? '' : HomeTypeSerializer.serialize(homeType!),
      "city": (cityName == null) ? '' : CityNameSerializer.serialize(cityName!),
      "district": (district == null) ? '' : DistrictEnumSerializer.serialize(district!),
      "bedrooms": (bedrooms == null) ? '' : bedrooms,
      "bathrooms": (bathrooms == null) ? '' : bathrooms,
      "gender": (gender == null) ? '' : GenderSerializer.serialize(gender!),
      "sorting": sortingOption,
      "pager": pager
    };
  }
}

