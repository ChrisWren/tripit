module TripIt
  class CarObject < ReservationObject
    datetime_param :start_date_time, :end_date_time
    address_param :start_location_address, :end_location_address
    string_param :start_location_hours, :start_location_name, :start_location_phone, :end_location_hours, :end_location_name, :end_location_phone, \
                 :car_description, :car_type, :mileage_charges
    traveler_param :driver
    
    def initialize(client, obj_id, source = nil)
      @client = client
      @obj_id = obj_id
      populate(source)
    end
    
    def populate(source)
      info = source || @client.get("/car", :id => @obj_id)["CarObject"]
      super(info)
      @start_date_time          = convertDT(info["StartDateTime"])
      @end_date_time            = convertDT(info["EndDateTime"])
      @start_location_address   = info["start_location_address"]
      @end_location_address     = info["end_location_address"]
      @start_location_hours     = info["start_location_hours"]
      @start_location_name      = info["start_location_name"]
      @start_location_phone     = info["start_location_phone"]
      @end_location_hours       = info["end_location_hours"]
      @end_location_name        = info["end_location_name"]
      @end_location_phone       = info["end_location_phone"]
      @car_description          = info["car_description"]
      @car_type                 = info["car_type"]
      @mileage_charges          = info["mileage_charges"]
      @driver                   = TripIt::Traveler.new(info["Driver"])
    end
  end
end