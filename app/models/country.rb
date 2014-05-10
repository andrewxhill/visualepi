class Country < ActiveRecord::Base

  CATEGORIES = ["EH_AirQuality", "EH_HealthImpacts", "EH_WaterSanitation", "EV_Agriculture", "EV_BiodiversityHabitat", "EV_ClimateEnergy", "EV_Fisheries", "EV_Forests", "EV_WaterResources"]
  def self.new_from_params(params)
    year = params["year"]
    year = params["country"]
  end

  def self.radar_chart(params = nil)
    if params["countries"].nil?
      {
        "year" => "2012",
        "data" => {"countries" => country_categories}
      }
    else
      country_names = params["countries"].map do |country|
        country.downcase.capitalize
      end
      countries = country_names.map do |country_name| 
        country = Country.find_by(country: country_name)
        {
          "year" => "2012",
          "data" => {
            "id" => country.iso,
            "name" => country_name,
            "categories" => country.categories
          }
        }
      end

    end
  end

  def self.country_categories
    all.map do |country|
      {
        "id" => country.iso,
        "name" => country.country,
        "categories" => country.categories
      }
    end
  end

  def categories
    CATEGORIES.map do |cat|
      {"name" => cat, "value" => send(cat)}
    end
  end
end