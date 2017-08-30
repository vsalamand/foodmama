module ApplicationHelper

  def instruction_lines(recipe)
    i = 1
    html = []
    recipe.instructions.split("\r\n").each do |line|
      unless line == "" || line == " "
        html << "<div class='instruction-line'>
                   <div class='instruction-number'><h3>#{i}</h3></div>
                   <div class='instruction-text'><p>#{line}</p></div>
                 </div>"
        i+=1
      end
    end
    return html.join.html_safe
  end
end




