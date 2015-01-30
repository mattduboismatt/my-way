module QuestionHelper
  def color_array
    ['green', 'blue', 'orange', 'purple', 'red', 'teal']
  end

  def randomize(colors)
    color = colors.shuffle.pop
    colors.delete(color)
    return color
  end


  def encouragement
    ['Keep Going!', "You're almost there!", "Just a few more!", "For Freedom!", "Some days you’re the pigeon; some days you’re the statue.", "Don't start no. Won't be no.", "There is always a light at the end of the tunnel. Sometimes it is a train."].sample
  end
end
