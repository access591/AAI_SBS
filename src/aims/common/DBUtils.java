/**
  * File       : DBUtils.java
  * Date       : 08/07/2007
  * Author     : AIMS 
  * Description: 
  * Copyright (2007) by the Navayuga Infotech, all rights reserved.
  */
package aims.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ResourceBundle;

import javax.sql.DataSource;

public class DBUtils {

	public static final int TODAY = 1;

	public static final int LAST_WEEK = 2;

	public static final int LAST_MONTH = 3;

	public static final int LAST_YEAR = 4;

	public static final int DATE_RANGE = 5;

	/**
	 * It'll get connection from driver class.
	 * 
	 * @return
	 */
	public static Connection getConnection() throws Exception {
		Log log = new Log(DBUtils.class);
		Connection conn = null;
		try {
			
			ResourceBundle bundle = ResourceBundle
					.getBundle("aims.resource.DbProperties");
			String driverClassName = bundle.getString("oracle.drivers");
			String url = bundle.getString("oracle.access.url");
			String username = bundle.getString("oracle.access.user");
			String pwd = bundle.getString("oracle.access.password");

			Class.forName(driverClassName.trim());
			conn = DriverManager.getConnection(url.trim(), username.trim(), pwd
					.trim());
		

		} catch (ClassNotFoundException ex) {
			System.out.println(ex.toString());

		} catch (SQLException ex) {
			System.out.println(ex.toString());

		} catch (Exception ex) {
			System.out.println(ex.toString());

		}

		return conn;
	}

	/**
	 * It'll get connection from datasource
	 * 
	 * @param dataSource
	 * @return
	 */
	public static Connection getConnection(DataSource dataSource)
			throws Exception {
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
		} catch (SQLException ex) {

		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return conn;
	}

	/**
	 * It'll close connection.
	 * 
	 * @param conn
	 */
	public static void close(Connection conn) {
		try {
			if (conn != null)
				conn.close();
		} catch (SQLException ex) {

			// throw new
			// UtilityException("2010",CommonUtil.getExceptionMessage("2010"));
		} catch (Exception ex) {

			// throw new
			// UtilityException("1013",CommonUtil.getExceptionMessage("1013")+ex.getMessage());
		}
	}
	public static void closeConnection(Connection con, Statement stmt, ResultSet rs) {
		if (rs != null) {
			try {
				rs.close();
				rs = null;
			} catch (SQLException se) {
				System.out.println("Problem in closing Resultset ");
			}
		}

		if (stmt != null) {
			try {
				stmt.close();
				stmt = null;
			} catch (SQLException se) {
				System.out.println("Problem in closing Statement.");
			}
		}

		try {
			if (con != null && !con.isClosed()) {
				con.close();
				con = null;
			}
		} catch (SQLException se) {
			System.out.println("Problem in closing Connection.");
		}

	}
	public static int getRecordCount(String Qry) throws Exception {
		ResultSet resultSet = null;
		Connection connection = null;
		Statement statement = null;
		int count = 0;
		try {
			connection = getConnection();
			if (connection != null) {
				statement = connection.createStatement();
				if (statement != null) {
					resultSet = statement.executeQuery(Qry);
					if (resultSet.next()) {
						count = resultSet.getInt(1);
					}
				}
			}
		} catch (SQLException sqlExp) {
			System.out.println(sqlExp.getMessage());
			throw new SBSException(sqlExp);
		} catch (Exception exp) {
			System.out.println(exp.getMessage());
			throw new SBSException(exp);
		} finally {
			closeConnection( connection, statement,resultSet);
		}

		return (count);
	}
	public static ResultSet getRecordSet(String selectQry, Statement statement)
	throws SBSException {

ResultSet resultSet = null;
try {
	if (statement != null) {
		resultSet = statement.executeQuery(selectQry);
	}

} catch (SQLException sqlExp) {
	System.out.println(sqlExp.getMessage());
	throw new SBSException(sqlExp);
} catch (Exception exp) {
	System.out.println(exp.getMessage());
	throw new SBSException(exp);
}

return resultSet;
}

	public static void closeConnection(ResultSet resultSet,
			PreparedStatement pstatement, Connection connection) {

		try {
			if (resultSet != null) {
				resultSet.close();
			}
			if (pstatement != null) {
				pstatement.close();
			}
			if (connection != null) {
				connection.close();
			}
		} catch (SQLException exp) {
			System.out.println("DBUtility:closeConnection:Exception:"
							+ exp.getMessage());
		}
	}
	public static void closeConnection(ResultSet resultSet,
			Statement statement, Connection connection) {

		try {
			if (resultSet != null) {
				resultSet.close();
			}
			if (statement != null) {
				statement.close();
			}
			if (connection != null) {
				connection.close();
			}
		} catch (SQLException exp) {
			System.out.println("DBUtility:closeConnection:Exception:"
							+ exp.getMessage());
		}
	}
	public static int executeUpdate(String updateQry) throws SBSException {
		int updateCount = 0;
		Connection connection = null;
		Statement statement = null;
		try {
			connection = DBUtils.getConnection();
			if (connection != null) {
				statement = connection.createStatement();
				if (statement != null) {
					updateCount = statement.executeUpdate(updateQry);
				}
			}
		} catch (SQLException sqlExp) {
			
			throw new SBSException(sqlExp.getMessage());
		} catch (Exception exp) {
		
			throw new SBSException(exp.getMessage());
		} finally {
			closeConnection(null, statement, connection);
		}
		return updateCount;

	}
}
