# -*- encoding : utf-8 -*-
class AdminController < ApplicationController
  def index
    # save all the stundents in an array
    # TODO: eager-loading
    @students = Student.first(10)

    # gon.watch.test = Time.now
  end

  def students
    # make the json for datatables
    if params['iDisplayStart'] and params['iDisplayLength'] then
      @students = Student.paginate(:page => params['iDisplayStart'], :per_page => params['iDisplayLength']).
                          includes(:machine => [:machine_states, :states])
    else
      @students = Student.all.includes(:machine => [:machine_states, :states])
    end

    if params['sSearch'] then
      @students.where('name LIKE ?', params['sSearch'])
    end

    if params['iSortingCols'] then
      @students.order('? DESC', params['iSortingCols'])
    end

    @json = {}
    @json['aaData'] = []
    @students.each { |stu|
      # alumno, cuil, s/n, modelo, estado, razón
      @json['aaData'] << [stu.id, stu.name, stu.cuil, stu.machine.sn, stu.machine.model,
                            stu.machine.states.last.name, stu.machine.machine_states.last.reason]
    }
    render :json => @json
  end

  def student_log
    @student = Student.includes(:machine => [:machine_states, :states]).find(params[:id])

  end

  def states_stats
    @students = Student.all.includes(:machine => [:machine_states, :states])
    @states   = {}
    @students.each { |stu|
      state = stu.machine.states.last.name
      @states[state] = 0 if not @states[state]
      @states[state] += 1
    }
    render :json => @states
  end

  def update_table
    @student = Student.find(params[:row_id])

    case params[:column]
    when "1" # name
      @student.name = params[:value]
      @student.save!
    when "2" # cuil
      @student.cuil = params[:value]
      @student.save!
    when "3" # sn
      @machine = @student.machine
      @machine.sn = params[:value]
      @machine.save!
    when "4" # model
      @machine = @student.machine
      @machine.model = params[:value]
      @machine.save!
    when "5" # state
      @state = State.find_or_create_by_name(params[:value])
      @student.machine.states << @state
    when "6" # reason
      @reason = @student.machine.machine_states.last
      @reason.reason = params[:value]
      @reason.save!
    end

    if request.xhr? then
      render :text => params[:value]
    end
  end

  def add_student
    if request.post?
      @student = Student.new
      @student.name = params[:student][:name]
      @student.cuil = params[:student][:cuil]
      @student.save!
      @student.machine = Machine.create(:sn => params[:student][:sn], :model => params[:student][:model])
      @machine = @student.machine
      @state = State.find_or_create_by_name(params[:student][:state])
      @machine.states << @state
      @reason = @machine.machine_states.last
      @reason.reason = params[:student][:reason]
      @reason.save!

      redirect_to admin_index_path
    end
  end

  def export_table
    require 'csv'
    @students = Student.all.includes(:machine => [:machine_states, :states])

    filename = "alumnos_#{Date.today.strftime('%d%b%y')}.csv"
    csv_data = CSV.generate do |csv|
      # head
      csv << ['ID', 'Alumno', 'CUIL', 'Número de Serie', 'Modelo', 'Estado Actual', 'Razón']
      # body
      @students.each do |stu|
        csv << [stu.id, stu.name, stu.cuil, stu.machine.sn, stu.machine.model,
                  stu.machine.states.last.name, stu.machine.machine_states.last.reason]
      end
    end

    send_data csv_data,
                :type => 'text/csv; charset=UTF-8; header=present',
                :disposition => "attachment; filename=#{filename}"
  end

  def stats
    if request.format == :json
      case params[:type]
      when 'usage'
        @usage = MachineState.all.group_by{ |item| item.send(:created_at).beginning_of_day }.
                  map { |v| [v.first, v.last.count] }
        render :json => @usage
      when 'students'
        @students = Student.all.includes(:machine => [:machine_states, :states])
        @states   = {}
        @students.each { |stu|
          state = stu.machine.states.last.name
          @states[state] = 0 if not @states[state]
          @states[state] += 1
        }
        render :json => @states
      when 'students_states'
        @changes = MachineState.select(:updated_at).all.
                    group_by{|ms| ms.updated_at.beginning_of_day}.map{ |ms| [ms.first, ms.last.count]}
        render :json => @changes
      end
    end
  end
end
