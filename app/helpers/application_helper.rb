module ApplicationHelper
    def current_user  
        if session[:user_id]
            current_user ||= User.find(session[:user_id])
        else
            current_user = nil
            nil
        end
    end

    def time_delta time
        if time < Time.now
            distance_of_time_in_words_to_now(time) + " ago"
        else
            distance_of_time_in_words_to_now(time) + " from now"
        end
    end

    def markdown(text)
        sanitize(BlueCloth::new(text).to_html)
    end

    def nice_date d
        d.strftime("%A, %B %d, %Y")
    end

    def nice_datetime d
        d.strftime("%I:%M %p %m-%d-%Y")
    end

    def role_labels user
        r = ""
        r << '<span class="label label-danger">Admin</span> ' if user.admin?
        r << '<span class="label label-warning">Judge</span> ' if user.judge?
        r << '<span class="label label-success">Recommender</span> ' if user.recommender?
        r << '<span class="label label-info">Applicant</span> ' if user.applicant?
        r << '<span class="label label-default">User</span> ' if user
        r.html_safe
    end

    def pluralize_word(count, noun, text = nil)
        if count != 0
            count == 1 ? "#{noun}#{text}" : "#{noun.pluralize}#{text}"
        else
            "#{noun.pluralize}#{text}"
        end
    end

    def application_status code
        case code
        when 100
            '<span class="label label-success">Complete</span>'
        when 0
            '<span class="label label-warning">Incomplete</span>'
        when 400
            '<span class="label label-danger">Discard</span>'
        when 80
            '<span class="label label-info">Waiting on 3rd Party</span>'
        when 180
            '<span class="label label-info">Complete - Waiting on 3rd Party</span>'
        else
            '<span class="label label-default">' + code.to_s + '</span>'
        end.html_safe
    end

    def review_status code
        case code
        when 100
            '<span class="label label-success">Complete</span>'
        when 0
            '<span class="label label-warning">Incomplete</span>'
        when 400
            '<span class="label label-danger">Discard</span>'
        when 80
            '<span class="label label-info">Waiting on Input</span>'
        end.html_safe
    end

    def panel_type scholarship
        if scholarship.active
            if scholarship.global
                'panel-success'
            else
                'panel-info'
            end
        else
            'panel-danger'
        end
    end
end
