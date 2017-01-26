<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Appointment_model extends CI_Model {

	public $t_appointments = 'vt_appointments_info';

	public function __construct(){

            parent::__construct();
	}

	public function get_employees(){
            $this->db->select('id, name, lastname');
            $query = $this->db->get('rt_employees');
            return $query->result();
        }
        
        public function get_specializations(){
            $this->db->select('id, name');
            $query = $this->db->get('rt_specialization');
                        
            return $query->result();
        }
        
        public function get_time_intervals(){
            $this->db->select('id, start, end');
            $query = $this->db->get('rt_time_interval');      
            
            return $query->result();
        }
        
        public function search_employees($specialization, $time_interval, $date){
            $query = $this->db->query("CALL `search_employees`('$specialization', '$time_interval', '$date');");
            return $query->result();
        }
        
        public function search_client($fio){
            $separate_fio = explode(' ', $fio);
            $name =  $separate_fio[0];       
            $lastname =  $separate_fio[1];
            
            $query = $this->db->query("CALL `search_client`('$name', '$lastname');");
            $query_res = $query->row();
            
            mysqli_next_result( $this->db->conn_id ); 
            $query->free_result();
            
            return ($query_res === NULL) ? false : $query_res->id;

        }
        
        public function add_appointment($employee_id, $date, $time_interval_id, $client_id){
            
            $query = $this->db->query("CALL `add_appointments`('$employee_id', '$date', '$time_interval_id', '$client_id');");
            return $query->result_id;

        }
        
        
        
}
