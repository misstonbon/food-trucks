require 'httparty'
require 'date'
require 'terminal-table'

class Trucks
    attr_reader :RESULTS_QTY, :DATE_NOW, :FIELDS, :HOUR_STRING, :MINUTE_STRING, :WEEK_DAY, :HOUR_FORMATTED, :TIME_FOR_QUERY, :query
    include HTTParty 
    base_uri "https://data.sfgov.org/resource/bbb8-hzi6.json"

    def initialize
        @date = DateTime.now
        @RESULTS_QTY = 10
        @FIELDS = 'applicant,location'
        @HOUR_STRING = "#{DateTime.now.hour}".rjust(2,'0')
        @MINUTE_STRING = "#{DateTime.now.minute}".rjust(2,'0')
        @WEEK_DAY = "#{DateTime.now.cwday}"
        @HOUR_FORMATTED = "\'#{@HOUR_STRING}:#{@MINUTE_STRING}\'"
        @TIME_FOR_QUERY = "#{@HOUR_FORMATTED} BETWEEN start24 AND end24"
        @query = "?$select=#{@FIELDS}&$where=#{@TIME_FOR_QUERY} AND dayorder=#{@WEEK_DAY}&$order=applicant ASC&$limit=#{@RESULTS_QTY}"
    end

    def trucks_response(offset = 0)
        query = "#{@query}&$offset=#{offset}"
        return self.class.get(query).parsed_response
    end 

end 

num = 0
page = 1
keep_paging = true
response = Trucks.new.trucks_response(0)

def clear 
    puts "\e[H\e[2J"
end 

def build_table_rows(data)
    trucks = []
    data.each do |result|
        trucks.push([result["applicant"],result["location"]])
    end 
    return trucks
end 

def build_table(response)
    table = Terminal::Table.new do |t|
    t.title = "****** FOOD TRUCKS OPEN NOW ******"
    t.headings = ['NAME', 'LOCATION']
    t.rows = build_table_rows(response)
    t.style = { :border_top => true, :border_bottom => true }
    end 
    return table 
end


def load_more(num)
    response = Trucks.new.trucks_response(num)
    return response
end

while keep_paging

    if response.length == 0
        puts "You have reached the end."
        break
    end 

    puts build_table(response)

    if page == 1 
        puts "See more results? (Y/N): "
        user_input = gets.chomp.downcase
        until user_input == 'y' || user_input == 'n'
            puts "I didn't get that. See more results? (Y/N): "
            user_input = gets.chomp.downcase
        end
        if user_input == 'y' 
           num += 10
           response = load_more(num)
           page += 1
           clear()
        else
            user_input == 'n'
            keep_paging = false 
            p 'BYE!'
            break
        end
    else
        puts "Where to? (next, prev, exit): "
        user_input = gets.chomp.downcase
        unless user_input == "next" || user_input == "prev" || user_input == "exit"
            puts "I didn't get that. Where to? (next, prev, exit): "
            user_input = gets.chomp.downcase
        end
        if user_input == "next"
            num += 10
            response = load_more(num)
        elsif user_input == "prev"
            clear()
            num -= 10
            response = load_more(num)
        elsif user_input == "exit"
            p 'BYE!'
            keep_paging = false
            break
        end
    end
end 

