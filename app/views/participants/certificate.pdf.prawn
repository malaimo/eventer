if @page_size != "LETTER" && @page_size != "A4"
  prawn_document(:page_layout => :landscape, :page_size => "LETTER") do |pdf|
    pdf.text "Solo puedes generar certificados en tamaño carta (LETTER) o A4 (A4)."
  end
else

  rep_logo_path = "#{Rails.root}/app/assets/images/rep-logo-transparent.png"
  kleer_logo_path = "#{Rails.root}/app/assets/images/K-kleer_horizontal_negro_web.png"

  prawn_document(:page_layout => :landscape, :page_size => @page_size) do |pdf|

    pdf.image rep_logo_path, :width => 150, :position => :right

    if @page_size == "LETTER"
  	 pdf.image kleer_logo_path, :width => 300, :at => [-55, 610]
    elsif @page_size == "A4"
  	 pdf.image kleer_logo_path, :width => 300, :at => [-55, 590]
    end 

    pdf.move_down 50

    pdf.text "<b>Kleer</b> certifies that", :align => :center, :size => 14, :inline_format => true
   
    pdf.move_down 20

    pdf.text 	"<b><i>#{@participant.fname} #{@participant.lname}</i></b>", 
    			:align => :center, :size => 72, :inline_format => true

    pdf.text "attended the course named", :align => :center, :size => 14

    pdf.move_down 10

    pdf.text "<b><i>#{@participant.event.event_type.name}</i></b>", :align => :center, :size => 24, :inline_format => true

    pdf.text 	"delivered in <b>#{@participant.event.city}, #{@participant.event.country.name}</b> " +
    			"on <b>#{@participant.event.human_date}, #{@participant.event.date.year}</b>",
    			:align => :center, :size => 14, :inline_format => true 

    pdf.line_width = 3

    pdf.stroke do
    	if @page_size == "LETTER"
    		pdf.rectangle [-25, 565], 770, 585
    	elsif @page_size == "A4"
    		pdf.rectangle [-25, 548], 820, 570
    	end
    end

    pdf.line_width = 1

    pdf.stroke do
    	if @page_size == "LETTER"
    		pdf.rectangle [-20, 560], 760, 575
    	elsif @page_size == "A4"
    	    pdf.rectangle [-20, 543], 810, 560
    	end
    end

  end

end