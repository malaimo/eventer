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

  def send_certificate(participant, host_url)
    @participant = participant
    @certificate_link_A4 = "#{host_url}/events/#{@participant.event.id}/participants/#{@participant.id}/certificate.pdf?page_size=A4&verification_code=#{@participant.verification_code}"
    @certificate_link_LETTER = "#{host_url}/events/#{@participant.event.id}/participants/#{@participant.id}/certificate.pdf?page_size=LETTER&verification_code=#{@participant.verification_code}"
    @markdown_renderer = Redcarpet::Markdown.new( Redcarpet::Render::HTML.new(:hard_wrap => true), :autolink => true)
    mail(to: @participant.email, from: "#{@participant.event.trainer.name} <eventos@kleerer.com>", subject: "Kleer | Certificado del #{@participant.event.event_type.name}")
  end
  
  def alert_event_monitor(participant, edit_registration_link)
    @participant = participant
    if !@participant.event.monitor_email.nil? && @participant.event.monitor_email != ""
      mail(to: @participant.event.monitor_email, 
          from: "Eventos <eventos@kleerer.com>", 
          subject: "[Keventer] Nuevo registro a #{@participant.event.event_type.name} en #{@participant.event.country.name}: #{@participant.fname} #{@participant.lname}",
          body: "Una nueva persona se registró a #{@participant.event.event_type.name} del #{@participant.event.human_date} en #{@participant.event.country.name}. Puedes ver/editar el registro en #{edit_registration_link}.")
    end
  end

  def alert_event_crm_push_finished(crm_push_transaction)
    if !crm_push_transaction.user.email.nil? && crm_push_transaction.user.email != ""
      mail(to: crm_push_transaction.user.email, 
          from: "Keventer <eventos@kleerer.com>", 
          subject: "[Keventer] Envío al CRM finalizado",
          body: "El último push al CRM que solicitaste ya ha finalizado.")
    end
  end

end
