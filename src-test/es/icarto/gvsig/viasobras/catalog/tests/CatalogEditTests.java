package es.icarto.gvsig.viasobras.catalog.tests;

import static org.junit.Assert.assertEquals;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

import org.junit.BeforeClass;
import org.junit.Test;

import es.icarto.gvsig.viasobras.catalog.domain.Catalog;
import es.icarto.gvsig.viasobras.catalog.domain.Tramo;
import es.icarto.gvsig.viasobras.catalog.domain.Tramos;
import es.icarto.gvsig.viasobras.catalog.domain.mappers.DomainMapper;

public class CatalogEditTests {

    static Connection c;

    @BeforeClass
    public static void connectToDatabase() throws SQLException {
	c = DriverManager.getConnection(
		"jdbc:postgresql://localhost:5432/vias_obras", "postgres",
		"postgres");
	Properties p = new Properties();
	p.setProperty("url", c.getMetaData().getURL());
	p.setProperty("username", "postgres");
	p.setProperty("password", "postgres");
	DomainMapper.setConnection(c, p);
    }

    @Test
    public void testUpdatePavimento() throws SQLException {
	String myValue = "B";

	// modify and save tramos
	Catalog.clear();
	Catalog.setCarretera("4606");
	Catalog.setConcello("27018");
	Tramos tipoPavimento = Catalog.getTramosTipoPavimento();
	for (Tramo t : tipoPavimento) {
	    t.setValue(myValue);
	    t.setStatus(Tramo.STATUS_UPDATE);
	}
	tipoPavimento.save();

	// check if that made effect
	Statement stmt = c.createStatement();
	ResultSet rs = stmt
		.executeQuery("SELECT tipopavime FROM inventario.tipo_pavimento WHERE carretera = '4606' AND municipio = '27018'");
	boolean updated = true;
	while (rs.next()) {
	    if (!rs.getString("tipopavime").equals(myValue)) {
		updated = false;
	    }
	}
	assertEquals(true, updated);
    }

}
