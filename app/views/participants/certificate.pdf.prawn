prawn_document(:page_layout => :landscape) do |pdf|
  pdf.text "Certificado de Asistencia"
  pdf.text @participant.event.event_type.name
  pdf.text @participant.fname + ' ' + @participant.lname
  pdf.text @participant.event.city
end