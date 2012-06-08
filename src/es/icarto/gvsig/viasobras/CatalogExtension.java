package es.icarto.gvsig.viasobras;

import com.iver.andami.PluginServices;
import com.iver.andami.plugins.Extension;
import com.iver.andami.plugins.IExtension;

import es.icarto.gvsig.viasobras.catalog.domain.mappers.DomainMapper;
import es.icarto.gvsig.viasobras.catalog.view.CatalogForm;
import es.udc.cartolab.gvsig.users.DBConnectionExtension;
import es.udc.cartolab.gvsig.users.utils.DBSession;

public class CatalogExtension extends Extension {

    public void execute(String actionCommand) {
	DBSession dbs = DBSession.getCurrentSession();
	DomainMapper.setConnection(dbs.getJavaConnection());
	CatalogForm dialog = new CatalogForm();
	PluginServices.getMDIManager().addWindow(dialog);
    }

    protected void registerIcons() {
	PluginServices.getIconTheme().registerDefault(
		"viasobras-catalogo",
		this.getClass().getClassLoader()
			.getResource("images/catalogo.png"));
    }

    public void initialize() {
	registerIcons();
    }

    public void postInitialize() {
	PluginServices.getMDIManager().closeAllWindows();
	IExtension dbconnection = PluginServices
		.getExtension(DBConnectionExtension.class);
	dbconnection.execute(null);
    }

    public boolean isEnabled() {
	DBSession dbs = DBSession.getCurrentSession();
	return dbs != null;
    }

    public boolean isVisible() {
	return true;
    }

}
