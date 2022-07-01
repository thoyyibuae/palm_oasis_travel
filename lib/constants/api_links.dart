class ApiLinks {
  // static String server = "http://palmoasistravel.com";
  // https://palmoasistravel.com/new/apidoc/#api-Package-Get_Package
  static String base = //server +
      "https://palmoasistravel.com/new/api";
  static String getPackages = "/packages";
  static String getCountries = "/countries";
  static String getHomepageCountries = "/home-countries";
  static String getBlogs = "/blogs";
  static String getSliders = "/sliders";
  static String getVisaTypes = "/visa/uae/types";
  static String getVisaNationalities = "/visa/uae/nationalities";

  static String getPackageDetails(int packageId, int hotelId) {
    return "/packages/view?package_id=$packageId&hotel_id=$hotelId";
  }

  static String getCountryDetails(int countryId) {
    return "/countries/$countryId";
  }

  static String getVisaRequirements(int countryId, int visaTypeId) {
    return "/visa/uae/get-visa-requirements?type_id=$visaTypeId&nationality_id=$countryId";
  }

  // static String refresh = "";
}
