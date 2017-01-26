<?php defined('BASEPATH') OR exit('No direct script access allowed'); ?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>Запись на приём</title>
        <link href="<?=$base_url?>public/css/appointment.css" rel="stylesheet" type="text/css"/>
        <link href="<?=$base_url?>public/css/pikaday.css" rel="stylesheet" type="text/css"/>
        <script defer src="<?=$base_url?>public/js/vue.js" type="text/javascript"></script>
        <script defer src="<?=$base_url?>public/js/moment.min.js" type="text/javascript"></script>
        <script defer src="<?=$base_url?>public/js/pikaday.js" type="text/javascript"></script>
        <script defer src="<?=$base_url?>public/js/appointment.js" type="text/javascript"></script>
<body>

    <div  class="container middle">
    <h1 class="container_head"> Запись на приём </h1>
    <div class="container_body">
                
        <form id="app_appointment" name="appointment_form" class="appointment">

            <input v-on:click='input_text' v-bind:class="errors.input_fio || errors.authentication ? 'text_danger' : ''" class="appointment_input" v-model='selection.fio' name="fio" type="text"
            ><button class="appointment_button"  v-on:click="authentication">Авторизация</button>

            
            <input v-on:click='input_text' class="appointment_input full_width" v-model='selection.date'  name="date"  type="text">
            
            <select class="appointment_select full_width" v-model='selection.specialization' name="specializations" >
                <option class="appointment_option" v-bind:disabled='item.disabled' v-bind:value="item.id" v-for="item in form_data.specializations">{{ item.name }}</option>
            </select>
            
            <select class="appointment_select" v-model='selection.time_interval' name="time_intervals" >
                <option class="appointment_option" v-bind:disabled='item.disabled' v-bind:value="item.id" v-for="item in form_data.time_intervals">{{ item.start }}</option>
            </select><button class="appointment_button"  v-on:click="search_employees">Поиск врача</button>
            
            <select  v-bind:class="[errors.search ? 'text_danger' : '', 'appointment_select', 'full_width']"  v-model='selection.employee' name="employees" >
                <option class="appointment_option" v-bind:selected="item.selected" v-bind:disabled='item.disabled' v-bind:value="item.id" v-for="item in form_data.employees">{{ `${item.name}  ${item.lastname}` }}</option>
            </select>
            
            <button class="appointment_button full_width" v-on:click="set_appointment">Записаться</button>
            
        </form>
            
    </div>

    <p class="footer"></p>
</div>

</body>
</html>