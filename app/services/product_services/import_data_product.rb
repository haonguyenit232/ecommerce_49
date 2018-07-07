require 'csv'
module ProductServices
  class ImportDataProduct
    attr_reader :errors
    def initialize()
      @errors = []
    end

    def call(csv_text)
      csv_text.force_encoding('ISO-8859-1') # dinh dang csv theo chuan ISO
      csv = CSV.parse(csv_text, :headers => true)
      line_count = 0 # khai bao so' row , row dau` tien =0 , row dau tien la` title
      csv.each do |row|
        line_count += 1 # bo row 0 , vi` no' k phai data
        params = row.to_hash # bat dau dem' tu row 1
        product = Product.find_by(id: params["id"].to_i)
        name = params["name"]
        price = params["price"]
        description = params["description"]
        quantity = params["quantity"]
        status = params["status"]
        category_id = params["category_id"]
        rate_average = params["rate_average"]
        del_flash = params["del_flash"]
        if product.nil?
          m = Product.new(
            name: name,
            price: price,
            description: description,
            quantity: quantity,
            status: status,
            category_id: category_id,
            rate_average: rate_average,
            del_flash: del_flash,
          )
        @errors << "row #{line_count}:" + m.errors.full_messages.join(', ') if !m.save
        else
          if product.update(
            name: name,
            price: price,
            description: description,
            quantity: quantity,
            status: status,
            category_id: category_id,
            rate_average: rate_average,
            del_flash: del_flash,
          )
          else
            @errors << "row #{line_count}:" + product.errors.full_messages.join(', ')
          end
        end
      end
    end
  end
end
