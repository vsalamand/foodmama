module ApplicationHelper


  def instruction_lines(recipe)
    i = 1
    html = []
    recipe.instructions.split("\r\n").each do |line|
      unless line == "" || line == " "
        html << "<h3>Etape #{i}</h3><p>#{line}</p>"
        i+=1
      end
    end
    return html.join.html_safe
  end

end




