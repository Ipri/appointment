/* global fetch */

var appointment = new Vue({
    el: '#app_appointment',
    data: {
        form_data:{
            specializations: [{id:0, name: 'Выберите специализацию', disabled: true, selected: true}],
            employees: [{id:0, name: 'Выберите врача', lastname: '', disabled: true, selected: true}],
            time_intervals: [{id:0, start: 'Выберите время', disabled: true}]
        },
        selection: {
            fio: 'Введите ФИО',
            client_id: null,
            specialization: 0,
            time_interval: 0,
            employee: 0,
            date: 'Выберите дату'
        },
        errors: {
            search: false,
            input_fio: false,
            authentication: false
        }
        
    },
    methods:{
        input_text(event){
            event.target.value = '';
        },
        get_data(url, prop){
            fetch(`${location.href}${url}`)
                    .then(res=>res.json())
                    .then(data=>this.form_data[prop].push(...data))
                    .catch(error => {
                        console.error(error);
                    });
        },
        
        search_employees(event){
            event.preventDefault();
            let post_data = new FormData();
            
            Object.keys(this.selection).forEach((input)=>{
                post_data.set(input, this.selection[input]);
            });

            fetch(`${location.href}search_employees`,
                    {
                        method: 'POST',
                        body: post_data,
                        credentials: "same-origin"
                    }
            )
            .then(res=>res.json())
            .then(data=>{
                this.form_data.employees.splice(1);
                if(data.length === 0){
                    alert('Нет доступных врачей!');
                    this.form_data.employees[0].name = 'Нет доступных врачей';
                    this.selection.employee = 0;
                    this.errors.search = true;
                    
                } else {
                    this.form_data.employees[0].name = 'Выберите врача';
                    this.errors.search = false;
                    this.form_data.employees.push(...data);
                }
            })
            .catch(error => {
                console.error(error);
                alert('Произошла ошибка! Проверьте введенные данные!');
            });
           
        },
        
        set_appointment(event){
            event.preventDefault();
            
            if(!this.selection.client_id) {
                this.errors.authentication = true;
                return alert('Вы неавторизованы!');
            }
            
            if(this.errors.search) return;

            let post_data = new FormData();

            Object.keys(this.selection).forEach((input)=>{
                post_data.set(input, this.selection[input]);
            });

            fetch(`${location.href}set_appointment`,
                {
                    method: 'POST',
                    body: post_data
                }
            )
            .then(res=>res.json())
            .then(result=>{
                if(result){
                    alert(`Вы записаны на прием!`);
                } else{
                    throw new Error(result);
                }
            })
            .catch(error => {
                console.error(error);
                alert('Произошла ошибка! Проверьте введенные данные!');
            });
        },
        
        authentication(event){
            event.preventDefault();
            
            if(this.selection.fio === 'Введите ФИО') {
                this.errors.input_fio = true;
                return;
            }
            
            if(this.selection.fio.split(' ').length !== 2){
                this.errors.input_fio = true;
                return;
            }
            
            let post_data = new FormData();

            post_data.set('fio', this.selection.fio);

            fetch(`${location.href}authentication`,
                {
                    method: 'POST',
                    body: post_data
                }
            )
            .then(res=>res.json())
            .then(client_id=>{
                
                this.selection.client_id = client_id;
         
                if(client_id){
                    alert('Вы успешно авторизовались!');
                    this.errors.input_fio = false;
                    this.errors.authentication = false;
                } else {
                    alert('Такого пользователя нет в системе!');
                    this.errors.authentication = true;
                }
            })
            .catch(error => {
                console.error(error);
                alert('Произошла ошибка! Проверьте введенные данные!');
            });            
        }
        
    },
    created: function() {
        this.get_data('/get_specializations', 'specializations');
        this.get_data('/get_time_intervals', 'time_intervals');
    },
    mounted: function(){
        var date_picker = new Pikaday({ 
              field: document.forms.appointment_form.children.date,
              format: "YYYY-MM-DD", 
              i18n: { 
                  previousMonth : 'Пред. месяц',
                  nextMonth     : 'След. месяц',
                  months        : ['Январь','Февраль','Март','Апрель','Май','Июнь','Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь'],
                  weekdays      : ['Воскресенье','Понедельник','Вторник','Среда','Четверг','Пятница','Суббота'],
                  weekdaysShort : ['Вс','Пн','Вт','Ср','Чт','Пт','Сб']
              },
              onSelect: (date) => {
                this.selection.date = date_picker.toString();
            }
          });
    }
});