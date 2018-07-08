require 'csv'
module ProductServices
  class ExportData
    def export_csv(header,head,arr)
      CSV.generate(headers: true) do |csv|
        csv << header
        arr.each do |array|
          a = []
          for i in 0...head.length
            a << array.send(head[i])
          end
          csv << a
        end
      end
    end
  end
end
# headers: true, hàng đầu tiên của tệp CSV sẽ được coi là hàng tiêu đề thay vì hàng dữ liệu.
# o day anh viet ham export dung cho tat ca moi thang` .
# em se truyen` vao` 3 thu'
# title cua file , ten cac field can in ra (send(head[i])), va array object can in ra
# tat ca service dc viet bang ruby
# csv<<header <=> csv.push(header)
# arr o day = Product.all
# arr la 1 danh sach product . => array la 1 product . =>product.send(head[i]) <=> product.id product.price,.......... @@
