/*
 * This file is part of ***  M y C o R e  ***
 * See http://www.mycore.de/ for details.
 *
 * MyCoRe is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * MyCoRe is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with MyCoRe.  If not, see <http://www.gnu.org/licenses/>.
 */

package de.gbv.reposis.tiho;

import java.util.Optional;

import org.mycore.datamodel.metadata.MCRBase;
import org.mycore.datamodel.metadata.MCRObject;
import org.mycore.mods.MCRMODSWrapper;
import org.mycore.pi.MCRPIGenerator;
import org.mycore.pi.MCRPIManager;
import org.mycore.pi.exceptions.MCRPersistentIdentifierException;
import org.mycore.pi.urn.MCRDNBURN;

public class TIHOGenerator extends MCRPIGenerator<MCRDNBURN> {

    private static final String MODS = "mods";

    private static final String PATTERN = "urn:nbn:de:gbv:95-$ArchiveNumber$C";

    public MCRDNBURN generate(MCRBase mcrBase, String additional) throws MCRPersistentIdentifierException {
        if (!mcrBase.getId().getTypeId().equals(MODS) || !(mcrBase instanceof MCRObject)) {
            throw new MCRPersistentIdentifierException(
                "The generator " + getGeneratorID() + " only supports the type " + MODS);
        }

        MCRMODSWrapper modsWrapper = new MCRMODSWrapper((MCRObject) mcrBase);
        String archiveNumber = Optional.ofNullable(modsWrapper.getElement("mods:identifier[@type='intern']"))
            .orElseThrow(()->new MCRPersistentIdentifierException("Keine Archivnummer angegeben!")).getTextTrim();
        String newURN = PATTERN.replace("$ArchiveNumber$", archiveNumber);

        return MCRPIManager.getInstance()
            .getParserForType("dnbUrn")
            .parse(newURN)
            .map(MCRDNBURN.class::cast)
            .orElseThrow(
                () -> new MCRPersistentIdentifierException("Could not generate URN for " + mcrBase.getId().toString()));
    }
}
