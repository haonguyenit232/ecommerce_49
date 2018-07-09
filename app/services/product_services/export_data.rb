require "csv"
module ProductServices
  class ExportData
    def export_csv header, head, arr
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
