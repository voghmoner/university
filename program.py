# def calc_dihedral(v1, v2, v3, v4):
#     """Calculate dihedral angle method.
#     Calculate the dihedral angle between 4 vectors
#     representing 4 connected points. The angle is in
#     ]-pi, pi].
#     @param v1, v2, v3, v4: the four points that define the dihedral angle
#     @type v1, v2, v3, v4: L{Vector}
#     """
#     ab = v1 - v2
#     cb = v3 - v2
#     db = v4 - v3
#     u = ab ** cb
#     v = db ** cb
#     w = u ** v
#     angle = u.angle(v)
#     # Determine sign of angle
#     try:
#         if cb.angle(w) > 0.001:
#             angle = -angle
#     except ZeroDivisionError:
#         # dihedral=pi
#         pass
#     return angle

# class Polypeptide(list):
#     """A polypeptide is simply a list of L{Residue} objects."""

#     def get_phi_psi_list(self):
#         """Return the list of phi/psi dihedral angles."""
#         ppl = []
#         lng = len(self)
#         for i in range(0, lng):
#             res = self[i]
#             try:
#                 n = res['N'].get_vector()
#                 ca = res['CA'].get_vector()
#                 c = res['C'].get_vector()
#             except Exception:
#                 # Some atoms are missing
#                 # Phi/Psi cannot be calculated for this residue
#                 ppl.append((None, None)
# )                res.xtra["PHI"] = None
#                 res.xtra["PSI"] = None
#                 continue
#             # Phi
#             if i > 0:
#                 rp = self[i - 1]
#                 try:
#                     cp = rp['C'].get_vector()
#                     phi = calc_dihedral(cp, n, ca, c)
#                 except Exception:
#                     phi = None
#             else:
#                 # No phi for residue 0!
#                 phi = None
#             # Psi
#             if i < (lng - 1):
#                 rn = self[i + 1]
#                 try:
#                     nn = rn['N'].get_vector()
#                     psi = calc_dihedral(n, ca, c, nn)
#                 except Exception:
#                     psi = None
#             else:
#                 # No psi for last residue!
#                 psi = None
#             ppl.append((phi, psi))
#             # Add Phi/Psi to xtra dict of residue
#             res.xtra["PHI"] = phi
#             res.xtra["PSI"] = psi
#         return ppl

# (2.9981223185025794, 2.568009951520466), (1.040506836546381, None)]


import Bio.PDB
for model in Bio.PDB.PDBParser().get_structure("1knv", "data/1knv.pdb") :
    for chain in model :
        polypeptides = Bio.PDB.PPBuilder().build_peptides(chain)
        for poly_index, poly in enumerate(polypeptides) :
            print "Model %s Chain %s" % (str(model.id), str(chain.id)),
            print "(part %i of %i)" % (poly_index+1, len(polypeptides)),
            print "length %i" % (len(poly)),
            print "from %s%i" % (poly[0].resname, poly[0].id[1]),
            print "to %s%i" % (poly[-1].resname, poly[-1].id[1])
            print poly.get_phi_psi_list()

# import MMTK.Proteins
# protein = MMTK.Proteins.Protein("data/1knv.pdb", model="no_hydrogens")
# for chain in protein :
#     print "%s length %i" % (chain.name, len(chain)),
#     print "from %s to %s" % (chain[0].name, chain[-1].name)
#     for residue in chain :
#         print residue.name, residue.phiPsi()