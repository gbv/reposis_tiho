package de.vzg.tiho;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.jdom2.Element;
import org.mycore.access.MCRAccessException;
import org.mycore.datamodel.metadata.MCRMetadataManager;
import org.mycore.datamodel.metadata.MCRObject;
import org.mycore.datamodel.metadata.MCRObjectID;
import org.mycore.frontend.cli.annotation.MCRCommand;
import org.mycore.frontend.cli.annotation.MCRCommandGroup;
import org.mycore.mods.MCRMODSWrapper;

@MCRCommandGroup(name = "TIHO Commands")
public class TIHOCommands {
    public static final Logger LOGGER = LogManager.getLogger();

    /**
     *
     */
    @MCRCommand(syntax = "add urn {0} to {1}", help = "Adds a URN to a mods document", order = 10)
    public static void validate(String urn, String mycoreIDString) throws MCRAccessException {
        final MCRObjectID mycoreID = MCRObjectID.getInstance(mycoreIDString);
        if(!MCRMetadataManager.exists(mycoreID)){
            LOGGER.error("The object {} does not exist!", mycoreIDString);
            return;
        }

        final MCRObject modsObject = MCRMetadataManager.retrieveMCRObject(mycoreID);
        final MCRMODSWrapper mcrmodsWrapper = new MCRMODSWrapper(modsObject);
        final Element element = mcrmodsWrapper.addElement("identifier");

        element.setAttribute("type","urn" );
        element.setText(urn);

        MCRMetadataManager.update(modsObject);
    }

}
