import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.*;  
import java.util.Properties;

import oracle.jdbc.pool.OracleDataSource;


/**
 * Required to run this demo: ojdbc8.jar plus access to an Oracle DB.
 *
 */
public class DbDemo {

	//local Oracle XE
	private final static String DB_URL_LOCAL_XE = "jdbc:oracle:thin:@localhost:1521/XE";
	
	//CSDB
	private final static String DB_URL_CSDB2 = "jdbc:oracle:thin:@csdb.csc.villanova.edu:1521/orcl.villanova.edu";
	
	// Add your user name and password that you use to login to Oracle SQL Server
	// Your password is: Sp + VU ID (e.g.: Sp123458)
	private final static String username = "adantoni"; 
	private final static String password = "Sp02256728";  

	//Prompting the user to enter values into customer table
	int custID;
	String pNum;
	String cName;
	String cEmail;
	
	public static void main(String[] args) throws Exception {
		DbDemo dbDemo = new DbDemo();
		dbDemo.examples();
	}
	
	public void examples() throws Exception {
		Connection connection = null;

		try {
			connection = openConnection();

			promptUser();

			insertCust(connection);
			
			basicQuery(connection);
			

		}
		catch (SQLException e) {
			System.out.println("Trouble opening connection or executing SQL: " + e.getMessage());
			throw e;
		}
		finally {
			if (connection != null) {
				connection.close();
			}
		}
	}

		private void basicQuery(Connection connection) throws SQLException {
			System.out.println("*****Retrieve All Customers*****");
			List<PR_CUSTOMERS> customers = retrieveAllCustomers(connection);
			for (PR_CUSTOMERS c : customers) {
				System.out.println(c);
			}
		}

		private void insertCust(Connection connection) throws SQLException {
			System.out.println("****Insert Customers****");
			Customer_Insert(connection, custID, pNum, cName, cEmail);
		}

		private List<PR_CUSTOMERS> retrieveAllCustomers(Connection connection) throws SQLException {
			List<PR_CUSTOMERS> customers = new ArrayList<PR_CUSTOMERS>();
	
			Statement statement = null;
			try {
				statement = connection.createStatement();
				ResultSet resultSet = statement.executeQuery("SELECT * FROM PR_CUSTOMERS");
				
				if (resultSet != null) {
					while (resultSet.next()) {
						PR_CUSTOMERS customer = map(resultSet);
						customers.add(customer);
					} 
				}
	
			}
			catch (SQLException e) {
				System.out.println("An exception occurred when executing a statement: " + e.getMessage());
				throw e;
			}
			finally {
				if (statement != null) {
					statement.close();
				}
			}
			
			return customers;
		}

		private void Customer_Insert(Connection connection, int customerId, String phonenum, String name, String email) throws SQLException
		{
			PreparedStatement prepStatement = null;  
			try {
				prepStatement = connection.prepareStatement("insert into PR_CUSTOMERS(CUSTOMERID, PHONENUM, NAME, EMAIL) VALUES (?, ?, ?, ?)");
				prepStatement.setInt(1, customerId);
				prepStatement.setString(2, phonenum);
				prepStatement.setString(3, name);
				prepStatement.setString(4, email);
				
				int res = prepStatement.executeUpdate();
				System.out.println(res);
			} 
			catch (SQLException e) {
				System.out.println("An exception occurred when executing a statement: " + e.getMessage());
				throw e;
			}
			finally {
				if (prepStatement != null) {
					prepStatement.close();
				}
			}	
		}

	

	



	private Connection openConnection() throws SQLException {
		Properties connectionProps = new Properties();
		connectionProps.put("user", username);
		connectionProps.put("password", password);

		OracleDataSource dataSource = new OracleDataSource();
		dataSource.setURL(DB_URL_CSDB2);
		dataSource.setConnectionProperties(connectionProps);
		
		Connection connection = dataSource.getConnection();
		return connection;
	}

		
	



	private PR_CUSTOMERS map(ResultSet resultSet) throws SQLException {
		int customerid = resultSet.getInt("customerid");
		String phonenum = resultSet.getString("phonenum");
		/* 
		if (resultSet.wasNull()) {
			phonenum = null;
		}
		*/
		String name = resultSet.getString("name");
		if (resultSet.wasNull()) {
			name = null;
		}

		String email = resultSet.getString("email");
		if (resultSet.wasNull()) {
			email = null;
		}
		
		PR_CUSTOMERS emp = new PR_CUSTOMERS(customerid, phonenum, name, email);
		return emp;
	}

	private Character convertToSingleChar(String raw) {
		Character single = null;
		if (raw != null && raw.length() > 0) {
			single = Character.valueOf(raw.charAt(0));
		}
		return single;
	}

	private void promptUser() {
		Scanner sc= new Scanner(System.in);    
		System.out.print("Enter the customer ID.\n"); 
		custID= sc.nextInt();  
		sc.nextLine();
		System.out.print("Enter the 10 digit customer phone number.\n");  
		pNum= sc.nextLine();  
		System.out.print("Enter the name of the customer.\n");  
		cName= sc.nextLine();  
		System.out.print("Enter the customer email.\n");
		cEmail= sc.nextLine();
		sc.close();  
	}

}
