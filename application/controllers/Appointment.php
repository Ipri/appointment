<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Appointment extends CI_Controller {
    
        public $data;
        
        public function __construct(){
            parent::__construct();
            $this->load->model('Appointment_model');
            $this->load->helper('url');
            $this->load->helper('form');
            
            $this->data = [];
            $this->data['base_url'] = base_url();
            
        }

	public function index(){
            $this->load->view('Appointment_view', $this->data);
	}
        
        public function get_employees(){
            echo json_encode($this->Appointment_model->get_employees());
	}
        
        public function get_specializations(){
            echo json_encode($this->Appointment_model->get_specializations());              
	}
        
        public function get_time_intervals(){
            echo json_encode($this->Appointment_model->get_time_intervals());     
	}
        
        public function search_employees(){
            $specialization_id = $this->input->post('specialization', TRUE);
            $time_interval_id = $this->input->post('time_interval', TRUE);
            $selected_date = $this->input->post('date', TRUE);
            echo json_encode(
                    $this->Appointment_model->search_employees(
                        $specialization_id,
                        $time_interval_id,
                        $selected_date));
            
           
        }
        
        public function set_appointment(){
                            
            $employee_id = $this->input->post('employee', TRUE);
            $time_interval_id = $this->input->post('time_interval', TRUE);
            $date = $this->input->post('date', TRUE);
            $client_id = $this->input->post('client_id', TRUE);

            $res = $this->Appointment_model->add_appointment($employee_id, $date, $time_interval_id, $client_id);
            
            echo  json_encode($res);
                
        }
        
        public function authentication(){
             $fio = $this->input->post('fio', TRUE);
             $client_id = $this->Appointment_model->search_client($fio);
             echo  json_encode($client_id);
        }
        
}
