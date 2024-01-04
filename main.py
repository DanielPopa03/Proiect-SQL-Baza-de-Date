from flask import Flask, render_template, request, url_for, redirect, session, json
import cx_Oracle

app = Flask(__name__, template_folder='templates')

# Database connection configuration
db_username = 'C##user_dani'
db_password = 'mypass'
db_host = 'localhost'  # Usually 'localhost' if the database is on the same machine
db_port = '1521'  # Usually 1521 for Oracle
db_service = 'xe'

# Database connection string
dsn = cx_Oracle.makedsn(db_host, db_port, service_name=db_service)
db_connection_string = f'{db_username}/{db_password}@{dsn}'

app.secret_key = 'your_secret_key'

# Route to render the home page
@app.route('/')
def home():
    return render_template('index.html')


@app.route('/CerintaC' ,methods=['POST', 'GET'])
def CerintaC():
    return render_template('CerintaC.html')

@app.route('/CerintaA',methods=['POST', 'GET'])
def CerintaA():

    connection = cx_Oracle.connect(db_connection_string)

    cursor = connection.cursor()
    #get the names of the users tables
    cursor.execute('SELECT TABLE_NAME FROM USER_TABLES') 

    user_tables = cursor.fetchall()
    cursor.close()
    connection.close()
    if request.method == 'POST':
        selected_option = request.form.get('selected_option', '')
        if selected_option != '':  # Check if the selected_option is not empty
            session['selected_option'] = selected_option
            return redirect(url_for('display_data'))

    return render_template('CerintaA.html', options=user_tables)

# Route to handle the button click and display data from the database
@app.route('/CerintaA/display_data', methods=['POST','GET'])
def display_data():
    try:
        if request.method == 'POST':
            array2_data = request.form.get('array2Data','')
            if array2_data != '':
                array2 = json.loads(array2_data)
                print(array2)
                # Establish a connection to the database
                connection = cx_Oracle.connect(db_connection_string)

                # Create a cursor to execute SQL queries
                cursor = connection.cursor()
            
                selected_option = session.get('selected_option')
                selected_option = selected_option.replace('(','').replace(")",'').replace("'",'').replace(',','')
                # Execute a sample SQL query (replace with your own query)
                if array2 == []:
                    cursor.execute('SELECT * FROM ' + selected_option )
                else:
                    result_string = ', '.join(array2)
                    cursor.execute('SELECT * FROM ' + selected_option + ' ORDER BY ' + result_string )
                # Get column names dynamically from cursor description
                column_names = [col[0] for col in cursor.description]

                # Fetch all rows from the result set
                data = cursor.fetchall()

                # Close the cursor and database connection
                cursor.close()
                connection.close()

                # Render the template with the fetched data
                return render_template('display_data.html', data=data, col_name=column_names, col1_name = column_names )

        # Establish a connection to the database
        connection = cx_Oracle.connect(db_connection_string)

        # Create a cursor to execute SQL queries
        cursor = connection.cursor()
    
        selected_option = session.get('selected_option')
        selected_option = selected_option.replace('(','').replace(")",'').replace("'",'').replace(',','')
    
        print("\n" + selected_option)
        # Execute a sample SQL query (replace with your own query)
        cursor.execute(('SELECT * FROM ' + selected_option))

        # Get column names dynamically from cursor description
        column_names = [col[0] for col in cursor.description]

        # Fetch all rows from the result set
        data = cursor.fetchall()

        # Close the cursor and database connection
        cursor.close()
        connection.close()

        # Render the template with the fetched data
        return render_template('display_data.html', data=data, col_name=column_names, col1_name = column_names, order = [] )

    except cx_Oracle.Error as error:
        return f"Error connecting to the database:{error}"

#Cerinta B
@app.route('/CerintaB',methods=['POST', 'GET'])
def CerintaB():

    connection = cx_Oracle.connect(db_connection_string)

    cursor = connection.cursor()
    #get the names of the users tables
    cursor.execute('SELECT TABLE_NAME FROM USER_TABLES') 

    user_tables = cursor.fetchall()
    cursor.close()
    connection.close()
    if request.method == 'POST':
        selected_option = request.form.get('selected_option', '')
        if selected_option != '':  # Check if the selected_option is not empty
            selected_option = selected_option.replace('(','').replace(")",'').replace("'",'').replace(',','')
            return redirect(url_for('CerintaBT', tabel = selected_option))
    return render_template('CerintaB.html', options=user_tables)


@app.route('/CerintaB/<tabel>',methods=['POST', 'GET'])
def CerintaBT(tabel):
    tabel = tabel.replace('(','').replace(")",'').replace("'",'').replace(',','')
    connection = cx_Oracle.connect(db_connection_string)

    cursor = connection.cursor()
    #get the names of the users tables
    cursor.execute('SELECT * FROM ' + tabel) 

    data = cursor.fetchall()
    cursor.close()
    connection.close()
    if request.method == 'POST'  and request.headers.get('Referer') == request.url:
        ajutor =request.form.get('array2Data','abc')
        ajutor= ajutor.replace('(','').replace(")",'').replace("'",'').replace('"','')
        ajutor = ajutor.split(",")
        connection = cx_Oracle.connect(db_connection_string)
        cursor = connection.cursor()
        cursor.execute(('SELECT * FROM ' + tabel))
        column_names = [col[0] for col in cursor.description]
        cursor.close()
        cursor = connection.cursor()
        Str =''
        i = 0
        for key,a in zip(column_names,ajutor):
            a = a.strip()
            Str += f" {key}='{a}' AND"
        Str = Str[:len(Str)-3]    
        print(ajutor)
        print('DELETE FROM ' + tabel +' WHERE '+ Str)
        cursor.execute('DELETE FROM ' + tabel +' WHERE '+ Str) 
        cursor.execute('COMMIT')
        cursor.close()
        connection = cx_Oracle.connect(db_connection_string)

        cursor = connection.cursor()
        #get the names of the users tables
        cursor.execute('SELECT * FROM ' + tabel) 

        data = cursor.fetchall()
        cursor.close()
        connection.close()
    return render_template('editDelete.html', options = data, tabel = tabel)

@app.route('/CerintaB/<path:tabel>/edit',methods=['GET', 'POST'])
def edit1(tabel):
    if  request.method == 'POST'  and request.headers.get('Referer') != request.url:
        initial_data = request.form.get('selected_option', '')
        initial_data = initial_data.replace('(','').replace(")",'').replace("'",'').replace('"','')
        initial_data = initial_data.split(",")
        session['abc'] = initial_data
    else:
        initial_data = session.pop('abc', None)
    connection = cx_Oracle.connect(db_connection_string)
    cursor = connection.cursor()
    tabel = tabel.split('/')[1]
    cursor.execute('SELECT * FROM ' + tabel)
    column_names = [col[0] for col in cursor.description]
    cursor.close()
    connection.close()
    if request.method == 'POST'  and request.headers.get('Referer') == request.url:
        updated_data = {}
        for key in column_names:
            updated_data[key] = request.form.get(key, '')
        
        aux = initial_data
        initial_data = {}
        for key,a in zip(column_names,aux):
            initial_data[key] = a

        print(initial_data)
        print(updated_data)
        st = ''
        dr = ''
        for key in column_names:
            st += f" {key} = '{updated_data[key].strip()}',"
            dr += f" {key} ='{initial_data[key].strip()}' AND"
        st = st[:len(st)-1]
        dr = dr[:len(dr)-3]
        connection = cx_Oracle.connect(db_connection_string)
        cursor = connection.cursor()
        print(f'UPDATE {tabel} SET  {st}  WHERE {dr}')
        cursor.execute('UPDATE ' + tabel + ' SET '+ st + ' WHERE '+ dr )
        cursor.execute('COMMIT')
        cursor.close()
        connection.close()
        print(st)
        print(dr)
        return render_template('index.html')
    return render_template("edit.html", zip=zip, col_name = column_names, python_dictionary = initial_data)


@app.route('/CerintaE',methods=['GET', 'POST'])
def CerintaE():
    connection = cx_Oracle.connect(db_connection_string)
    cursor = connection.cursor()

    cursor.execute('SELECT * FROM CLIENT WHERE ID_CLIENT = 3' )
    client = cursor.fetchall()
    c = [col[0] for col in cursor.description]
    cursor.execute('SELECT * FROM COMANDA WHERE ID_CLIENT = 3' )
    comanda = cursor.fetchall()
    c1 = [col[0] for col in cursor.description]
    cursor.execute('SELECT * FROM PRODUS_COMANDAT WHERE ID_COMANDA BETWEEN 1030 AND 1060')
    produs_comandat = cursor.fetchall()
    c2 = [col[0] for col in cursor.description]
    cursor.execute('SELECT * FROM FACTURA WHERE ID_COMANDA BETWEEN 1030 AND 1060' )
    factura = cursor.fetchall()
    c3 = [col[0] for col in cursor.description]

    cursor.execute('DELETE FROM CLIENT WHERE ID_CLIENT = 3')

    cursor.execute('SELECT * FROM COMANDA WHERE ID_COMANDA BETWEEN 1030 AND 1060' )
    comanda1 = cursor.fetchall()
    cursor.execute('SELECT * FROM PRODUS_COMANDAT WHERE ID_COMANDA BETWEEN 1030 AND 1060')
    produs_comandat1 = cursor.fetchall()
    cursor.execute('SELECT * FROM FACTURA WHERE ID_COMANDA BETWEEN 1030 AND 1060' )
    factura1 = cursor.fetchall()

    cursor.execute('ROLLBACK')
    cursor.close()
    connection.close()
    return render_template("CerintaE.html", client = client, comanda = comanda, produs_comandat = produs_comandat, factura = factura,
   comanda1 = comanda1, produs_comandat1 = produs_comandat1, factura1 = factura1, c = c, c1 = c1, c2 = c2, c3 = c3)

if __name__ == '__main__':
    connection = cx_Oracle.connect(db_connection_string)
    cursor = connection.cursor()
    #cursor.execute("INSERT INTO FIRMA_DE_CURIERAT VALUES (80320, 'SDAWDA', 'CAWCAC')")
    cursor.execute("COMMIT")
    cursor.close()
    connection.close()
    app.run(debug=True)
