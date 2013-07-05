class EventMailer < ActionMailer::Base
  default from: "entrenamos@kleer.la"
  
  def welcome_new_webinar_participant(participant)
      @participant = participant
      mail(to: @participant.email, subject: "Kleer | Te has registrado al #{@participant.event.event_type.name}" )
  end
  
end
