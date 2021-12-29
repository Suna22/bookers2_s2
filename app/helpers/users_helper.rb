module UsersHelper
  def ratio(num1, num2)
    if num2 == 0
      return "--%"
    end
    (num1 * 100 / num2).to_s + "%"
  end
end
