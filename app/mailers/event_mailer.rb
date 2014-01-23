# encoding: utf-8

class EventMailer < ActionMailer::Base
  
  add_template_helper(DashboardHelper)

  def welcome_new_webinar_participant(participant)
    @participant = participant
    mail(to: @participant.email, from: "Eventos <eventos@kleerer.com>", subject: "Kleer | #{@participant.event.event_type.name}" )
  end
  
  def notify_webinar_start(participant, webinar_link)
    @participant = participant
    @webinar_link = webinar_link
    mail(to: @participant.email, from: "Eventos <eventos@kleerer.com>", subject: "Kleer | Estamos iniciando! Sumate al webinar #{@participant.event.event_type.name}" )
  end

  def welcome_new_event_participant(participant)
    @participant = participant
    @markdown_renderer = Redcarpet::Markdown.new( Redcarpet::Render::HTML.new(:hard_wrap => true), :autolink => true)
    mail(to: @participant.email, from: "Eventos <eventos@kleerer.com>", subject: "Kleer | #{@participant.event.event_type.name}")
  end
  
  def alert_event_monitor(participant, edit_registration_link)
    @participant = participant
    if !@participant.event.monitor_email.nil? && @participant.event.monitor_email != ""
      puts "Enviando email a #{@participant.event.monitor_email} - #{edit_registration_link}"
      mail(to: @participant.event.monitor_email, 
          from: "Eventos <eventos@kleerer.com>", 
          subject: "[Keventer] Nuevo registro a #{@participant.event.event_type.name}: #{@participant.fname} #{@participant.lname}",
          body: "Una nueva persona se registró a #{@participant.event.event_type.name}. Puedes ver/editar el registro en #{edit_registration_link}.")
    end
  end

end
