module DashHelper
    def crawel_data
        
        (9.months.ago.to_date...Date.today + 1).map do |date|
            {
                created_at: date,
                crawel: @crawel_data_per_day.where('date(created_at) = ?' , date).count,
                
            }   
        end
    end
end
