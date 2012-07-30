package es.icarto.gvsig.viasobras.catalog.view.load;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.iver.andami.PluginServices;
import com.iver.cit.gvsig.ProjectExtension;
import com.iver.cit.gvsig.project.Project;
import com.iver.cit.gvsig.project.documents.ProjectDocument;
import com.iver.cit.gvsig.project.documents.ProjectDocumentFactory;
import com.iver.cit.gvsig.project.documents.view.ProjectViewFactory;
import com.iver.cit.gvsig.project.documents.view.gui.View;

import es.icarto.gvsig.elle.db.DBStructure;
import es.udc.cartolab.gvsig.elle.utils.ELLEMap;
import es.udc.cartolab.gvsig.elle.utils.LoadLegend;
import es.udc.cartolab.gvsig.elle.utils.MapDAO;
import es.udc.cartolab.gvsig.users.utils.DBSession;

public class MapLoader {

    public static String DEFAULT_MAP_NAME = "Caracter�sticas";

    public static void loadMap(String mapName) {
	View view = createView(mapName);
	try {
	    ELLEMap map = MapDAO.getInstance().getMap(view, mapName,
		    LoadLegend.DB_LEGEND, mapName);
	    if (map.getName().equals(DEFAULT_MAP_NAME)) {
		// filter concellos & tramos
		String whereConcellos = WhereAdapter
			.getClause(WhereAdapter.CONCELLOS);
		map.getLayer("Concellos").setWhere(whereConcellos);
		String whereTramos = WhereAdapter
			.getClause(WhereAdapter.TRAMOS);
		map.getLayer("Tipo de pavimento").setWhere(whereTramos);
		map.getLayer("Ancho de plataforma").setWhere(whereTramos);
	    }
	    map.load(view.getProjection());
	    PluginServices.getMDIManager().addWindow(view);
	} catch (Exception e) {
	    e.printStackTrace();
	}
    }

    public static void loadDefaultMap() {
	createMap(DEFAULT_MAP_NAME);
	loadMap(DEFAULT_MAP_NAME);
    }

    private static boolean createMap(String mapName) {
	List<Object[]> rows = new ArrayList<Object[]>();
	Object[] oceano = { "Oc�ano", "oceano", 1, true, null, null, "",
	"info_base" };
	Object[] portugal = { "Portugal", "portugal", 2, true, null, null,
		"", "info_base" };
	Object[] provincias_galicia = { "Provincias Galicia",
		"provincias_galicia", 3, true, null, null, "", "info_base" };
	Object[] provincias_limitrofes = { "Provincias Espa�a",
		"provincias_limitrofes", 4, true, null, null, "", "info_base" };
	Object[] concellos = { "Concellos", "concellos", 5, true, null,
		null, "", "info_base" };
	Object[] carreteras = { "Carreteras", "rede_carreteras", 6,
		true, null, null, "", "inventario" };
	Object[] pavimento = { "Tipo de pavimento", "tipo_pavimento", 7,
		true, null, null, "", "inventario" };
	Object[] plataforma = { "Ancho de plataforma", "ancho_plataforma", 8,
		true, null, null, "", "inventario" };
	rows.add(portugal);
	rows.add(provincias_galicia);
	rows.add(provincias_limitrofes);
	rows.add(oceano);
	rows.add(concellos);
	rows.add(carreteras);
	rows.add(pavimento);
	rows.add(plataforma);
	try {
	    DBSession dbs = DBSession.getCurrentSession();
	    if (!dbs.tableExists(DBStructure.getSchema(),
		    DBStructure.getMapTable())) {
		MapDAO.getInstance().createMapTables();
	    }
	    MapDAO.getInstance().saveMap(rows.toArray(new Object[0][0]),
		    mapName);
	    return true;
	} catch (SQLException e) {
	    e.printStackTrace();
	    return false;
	}
    }

    private static View createView(String mapName) {
	View view = null;
	Project project = ((ProjectExtension) PluginServices
		.getExtension(ProjectExtension.class)).getProject();
	ProjectDocumentFactory viewFactory = Project
		.getProjectDocumentFactory(ProjectViewFactory.registerName);
	ProjectDocument projectDocument = viewFactory.create(project);
	projectDocument.setName(mapName);
	project.addDocument(projectDocument);
	view = (View) projectDocument.createWindow();
	view.getWindowInfo().setMaximized(true);
	return view;
    }

    public static List<String> getAllMapNames() {
	String[] maps;
	try {
	    maps = MapDAO.getInstance().getMaps();
	    return Arrays.asList(maps);
	} catch (SQLException e) {
	    maps = new String[] { "" };
	    return Arrays.asList(maps);
	}
    }

}
