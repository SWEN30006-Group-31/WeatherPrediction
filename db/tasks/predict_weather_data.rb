
require 'Matrix'

namespace :predict do

  # predict regression
  task :predict_regression => :environment do
    class Regression
      def initialize (arr_x, arr_y)
        @arr_x = arr_x
        @arr_y = arr_y
        calculation
      end

      # the arr_ticket is used to keep
      # the information of the regression
      # arr_ticket ["regression_type", distance, "equation",a,b]
      def judge_ticket str
        case str
          when "linear"
            arr_ticket = linear
            puts arr_ticket[2]
          when "polynomial"
            arr_ticket = polynomial
            puts arr_ticket[2]
          when "exponential"
            arr_ticket = exponential
            puts arr_ticket[2]
          when "logarithmic"
            arr_ticket = logarithmic
            puts arr_ticket[2]
        end
      end

      #do common calculations
      def calculation
        #number of x(@n), sum of x(@sumx)
        @n = @arr_x.size
        @sumxx = eval @arr_x.map { |x| x ** 2 }.join('+')
      end


      #A.  Linear Regression
      def linear

        # 1. do calculation: 1.sumxy, 2.average x,y
        sumxy = 0.0
        0.upto(@n - 1) do |i|
          sumxy = sumxy + (@arr_x[i] * @arr_y[i])
        end
        x_average = @arr_x.inject(0.0) { |r, x| r + x }/ @n
        y_average = @arr_y.inject(0.0) { |r, x| r + x }/ @n

        # 2. get a, b
        a = ((y_average * (@sumxx) - x_average * (sumxy)) / (@sumxx - @n * x_average ** 2)).round(2)
        b = ((sumxy - @n * x_average * y_average) / (@sumxx - @n * x_average ** 2)).round(2)

        # 3.calculate the y of new equation
        # put them into an array
        arr_yafter = Array.new # calculate new y (y')
        @arr_x.each do |x|
          arr_yafter << b * x + a # the array of y' (new y)
        end

        # 4.get the difference between y' and y
        distance = get_distance (arr_yafter)

        # 5. generate the equation in required format
        if a > 0
          stra = "+ #{a}"
        else
          stra ="#{a}"
        end
        equation = "#{b}x #{stra}"
        coefficients = [a,b]

        # 6. return arr_ticket
        arr_ticket= ["linear", distance, equation,coefficients] # ticket for linear
        return arr_ticket
      end

      def polynomial #B.  Polynimial Regression ====

        # 1.get the coefficients
        distance_and_coefficients = Array.new() { Array.new() }

        (2..10).each do |degree|
          arr_yafter = Array.new
          x_data = @arr_x.map { |x_i| (0..degree).map { |pow| (x_i**pow).to_f } }
          mx = Matrix[*x_data]
          my = Matrix.column_vector(@arr_y)
          @coefficients = ((mx.t * mx).inv * mx.t * my).transpose.to_a[0]
          @coefficients.map! { |x| x.round(2) } # use two decimal to make decision

          # 2.calculate the value of y' for new equation
          @arr_x.each do |x|
            yaftering = 0.0
            0.upto(degree) do |i|
              yaftering = yaftering + @coefficients[i] * x ** i
            end
            arr_yafter << yaftering # the array of y' (new y)
          end

          # 3.put all the distance and corresponding coefficients into an array
          distance_and_coefficients << [get_distance(arr_yafter), @coefficients]

        end

        # 4.get closest distance and corresponding coefficients
        distance_and_coefficients = distance_and_coefficients.sort
        coefficients_closet = distance_and_coefficients[0][1]
        # 5.generate the equation with the required format
        polynomial = Array.new
        if coefficients_closet[0] != 0.00
          polynomial << "#{coefficients_closet[0]}"
        end
        if coefficients_closet[1] != 0.00
          polynomial << "#{coefficients_closet[1]}x"
        end

        2.upto(coefficients_closet.size - 1) do |i|
          if coefficients_closet[i] != 0.0
            polynomial << ("#{coefficients_closet[i]}x^#{i}")
          end
        end

        (polynomial.size - 2).downto(0) do |i|
          if polynomial[i].match /^[0-9]+/
            polynomial[i] = " + #{polynomial[i]}"
          end
        end

        equation = polynomial.reverse.join(' ')
        # 6.get arr_ticket
        arr_ticket = ["polynomial", distance_and_coefficients[0][0], equation,coefficients_closet]
        return arr_ticket
      end


      def exponential # C.Exponential Regression

        # 1. calculation
        # a. get sumx
        sumx = eval @arr_x.join('+')

        # b.get sumlny
        sumlny = 0.0
        sumxlny = 0.0
        arr_ticket = Array.new()

        # 2. use begin..end to catch the Math::DomainError
        begin
          @arr_y.each do |y|
            sumlny = sumlny + Math.log(y)
          end

          # c.get sumxlny
          0.upto(@arr_x.length-1) do |i|
            sumxlny = sumxlny + (@arr_x[i] * Math.log(@arr_y[i]))
          end

          # 3. calculate a b
          c = @n * @sumxx - sumx ** 2
          a = (sumlny * @sumxx - sumx * sumxlny) / c
          b = ((@n * sumxlny - sumx * sumlny) / c).round(2)

          a = ((Math::E) ** a).round(2)

          #4. get new y (y')
          arr_yafter = Array.new
          @arr_x.each do |x|
            arr_yafter << a * Math::E ** (b * x) # the array of y' (new y)
          end
          #5. get difference between y' and y and get equation
          distance = get_distance (arr_yafter)
          equation = "#{a}*e^#{b}x"
            #6. dealing with the Math::DomainError:
            # if one regression catch the Math::DomainError, the distance would be -1
        rescue Math::DomainError
          arr_ticket[0] = "exponential"
          arr_ticket[1] = -1
          arr_ticket[2] = "Cannot perform exponential regression on this data"
        end
        #7. generate arr_ticket
        coefficients = [a,b]
        if arr_ticket[2] == nil
          arr_ticket= ["exponential", distance, equation,coefficients] # ticket for linear
        end
        return arr_ticket

      end

      #D. Logarithmic Regression
      def logarithmic

        #1. calculation
        #a. sumy
        arr_ticket = Array.new
        sumy = eval @arr_y.join('+')
        begin

          #b. sumylnx
          sumylnx = 0.0
          0.upto(@arr_x.length - 1) do |i|
            sumylnx = sumylnx + @arr_y[i] * Math.log(@arr_x[i])
          end

          #c.sumlnx
          sumlnx = 0.0
          @arr_x.each do |x|
            sumlnx = sumlnx + Math.log(x)
          end

          #d. sumlnxlnx
          sumlnxlnx = 0.0
          @arr_x.each do |x|
            sumlnxlnx = sumlnxlnx + (Math.log(x)) ** 2
          end
          #2. get a, b
          b = (@arr_x.size * sumylnx - sumy * sumlnx) / (@arr_x.size * sumlnxlnx - sumlnx**2)
          a = ((sumy - b * sumlnx) / (@n)).round(2)
          b = b.round(2)

          #3. get new y (y')
          arr_yafter = Array.new
          @arr_x.each do |x|
            arr_yafter << b * Math.log(x) + a # the array of y' (new y)
          end
          #4. get difference between y' and y
          distance = get_distance (arr_yafter)
          #5. get equation
          if a > 0
            stra = "+ #{a}"
          else
            stra ="#{a}"
          end
          equation = "#{b}*ln(x) #{stra}"
            # dealing with the Math::DomainError
        rescue Math::DomainError
          arr_ticket[0] = "exponential"
          arr_ticket[1] = -1
          arr_ticket[2] = "Cannot perform logarithmic regression on this data"
        end

        #6. generate arr_ticket
        coefficients = [a,b]
        if arr_ticket[2] == nil
          arr_ticket= ["logarithmic", distance, equation,coefficients] # ticket for linear
        end
        return arr_ticket
      end


      #  get the difference
      # between y'(y that get from equation)
      # and y (original y in the data set)
      def get_distance arr_yafter
        distance = 0.0
        0.upto(@n - 1) do |i|
          distance = distance + (@arr_y[i] - arr_yafter[i]) ** 2
        end
        distance = Math.sqrt(distance)
        return distance
      end

      #E. best_fit arr_ticket= ["linear", distance, equation,coefficients]
      def best_fit

        # get all the arr_ticket for all regression types
        ticket_linear = linear
        ticket_polynomial = polynomial
        ticket_exponential = exponential
        ticket_logarithmic =logarithmic

        # sort by the second row,
        # which store the distance of each regression equation
        arr_bestfit = [ticket_linear, ticket_polynomial,
                       ticket_exponential,
                       ticket_logarithmic].sort { |x, y| x[1] <=> y[1] }

        #  delete the distance which are -1, the Math::DomainError
        i = 0
        while arr_bestfit[i] != nil && arr_bestfit[i][1] < 0
          arr_bestfit.delete_at(i)
          i += 1
        end

        # the first one in the array
        # possesses the smallest distance
        puts arr_bestfit[0][2]
        return arr_bestfit
      end
    end

    predict temperature
    @observations = Observation.all
    @locations = Location.all
    arr_y_tem = []
    arr_x = []
    for location in @locations
      i = 0
      for record in location.observations
        arr_y_tem << record.temperature
        arr_x << i
        i+=1

        # to get the best fit
        # get the type of the best_fit regression
        # ["linear", distance, equation,coefficients]
        function_info= Regression.new(arr_x, arr_y_tem).best_fit
        @prediction = Prediction.new
        @prediction.temperature = getValue(function_info[0],arr_x,function_info[3])
      end
    end




    def getValue best_type, arr_x,coefficients
      x = arr_x.last + 1
      if tem_best_type =="linear"

        y = coeffieicnts[1] * x + coeffieients[0]
      end
      if tem_best_type =="polynomial"

        y = 0
        i = 0
        for coe in coefficients
          y = y + coe * (x ** i)
          i += 1
        end
      end
      if tem_best_type == "exponential"
        y = coefficients[0]*(e ** (coefficients[1] * x))

      end
      if tem_best_type == "logarithmic"
        y = coefficients[1]* Math.log(x) + conefficients[0] *x

      end

      return y

    end






  end







end
