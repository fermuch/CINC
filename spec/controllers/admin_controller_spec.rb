# -*- encoding : utf-8 -*-
require 'spec_helper'

describe AdminController do

  before :each do
    @student = Fabricate(:student)
    @user    = Fabricate(:user)
    sign_in :user, @user
  end

  describe "GET 'index'" do
    it "returns success and renders index.html.haml" do
      get 'index'
      response.should be_success
      response.should render_template(:index)
    end

    it "stores first 10 users" do
      get 'index'
      assigns(:students).length.should_not be_nil
    end
  end

  describe "GET 'students'" do
    it "returns success" do
      get 'students'
      response.should be_success
    end

    it 'returns a valid json' do
      get :students
      response.header['Content-Type'].should include('application/json')
    end

    it 'can search for a student' do
      Fabricate.times(100, :student, name: "Student-#{Random.rand(1000)}")
      get :students, {:sSearch => 'test'}
      json = JSON.parse(response.body)
      expect(json['aaData'][0][1]).to eq("Test")
    end

    it "limits the number of results" do
      get :students, {:iDisplayStart => 1, :iDisplayLength => 1}
      Fabricate.times(100, :student, name: "Student-#{Random.rand(1000)}")
      json = JSON.parse(response.body)
      expect(json['aaData'].count).to eq(1)
    end
  end

  describe "GET 'student_log'" do
    it "returns success and renders student_log.html.haml" do
      get 'student_log', {:id => 1}
      response.should be_success
      response.should render_template(:student_log)
    end

    it "stores first 10 users" do
      get 'student_log', {:id => 1}
      assigns(:student).should be_instance_of(Student)
      assigns(:student).should eq(@student)
    end
  end

  describe 'states_stats' do
    it "returns success" do
      get 'states_stats'
      response.should be_success
    end

    it 'returns a valid json' do
      get 'states_stats'
      response.header['Content-Type'].should include('application/json')
    end
  end

  describe "update_table" do
    # 1 = name
    # 2 = cuil
    # 3 = S/N
    # 4 = Model
    # 5 = State
    # 6 = Reason
    it "updates the name" do
      xhr :post, :update_table, {:row_id => 1, :column => 1, :value => 'Foo Bar'}
      expect(Student.first.name).to eq('Foo Bar')
    end

    it "updates the cuil" do
      xhr :post, :update_table, {:row_id => 1, :column => 2, :value => '42'}
      expect(Student.first.cuil).to eq('42')
    end

    it "updates the serial number" do
      xhr :post, :update_table, {:row_id => 1, :column => 3, :value => '23'}
      expect(Student.first.machine.sn).to eq('23')
    end

    it "updates the model" do
      xhr :post, :update_table, {:row_id => 1, :column => 4, :value => 'New Model'}
      expect(Student.first.machine.model).to eq('New Model')
    end

    it "updates the state" do
      xhr :post, :update_table, {:row_id => 1, :column => 5, :value => 'New State'}
      expect(Student.first.machine.states.last.name).to eq('New State')
    end

    it "updates the reason" do
      xhr :post, :update_table, {:row_id => 1, :column => 6, :value => 'New Reason'}
      expect(Student.first.machine.machine_states.last.reason).to eq('New Reason')
    end
  end

  describe "GET/POST 'add_student'" do
    it "creates a new user" do
      data = {}
      data[:student] = {}
      data[:student][:name]   = 'New Student'
      data[:student][:cuil]   = '666'
      data[:student][:sn]     = '1111111'
      data[:student][:model]  = 'new_model'
      data[:student][:state]  = 'new_state'
      data[:student][:reason] = 'new_reason'

      post :add_student, data

      student = Student.last
      expect(student.name).to                               eq(data[:student][:name])
      expect(student.cuil).to                               eq(data[:student][:cuil])
      expect(student.machine.sn).to                         eq(data[:student][:sn])
      expect(student.machine.model).to                      eq(data[:student][:model])
      expect(student.machine.states.last.name).to           eq(data[:student][:state])
      expect(student.machine.machine_states.last.reason).to eq(data[:student][:reason])
    end

    it "success and renders add_student.html.haml" do
      get 'add_student'
      response.should be_success
      response.should render_template(:add_student)
    end
  end

  describe "GET 'export_table'" do
    it "exports the list of students" do
      get :export_table
      response.headers['Content-Type'].should eq('text/csv; charset=UTF-8; header=present')
      response.headers['Content-Disposition'].should eq("attachment; filename=alumnos_#{Date.today.strftime('%d%b%y')}.csv")
    end
  end

  describe "GET 'stats'" do
    it "returns a valid JSON on stat 'usage'" do
      xhr :get, :stats, {:type => 'usage', :format => 'json'}
      response.should be_success
      response.header['Content-Type'].should include('application/json')
    end

    it "returns a valid JSON on stat 'students'" do
      xhr :get, :stats, {:type => 'students', :format => 'json'}
      response.should be_success
      response.header['Content-Type'].should include('application/json')
    end

    it "returns a valid JSON on stat 'students_states'" do
      xhr :get, :stats, {:type => 'students_states', :format => 'json'}
      response.should be_success
      response.header['Content-Type'].should include('application/json')
    end

    it "loads the default page and renders stats.html.haml" do
      get :stats
      response.should be_success
      response.should render_template(:stats)
    end
  end


end
