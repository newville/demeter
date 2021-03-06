..
   Artemis document is copyright 2016 Bruce Ravel and released under
   The Creative Commons Attribution-ShareAlike License
   http://creativecommons.org/licenses/by-sa/3.0/


A worked example (in text!)
===========================


The Atoms input file
~~~~~~~~~~~~~~~~~~~~

Here is an example of :demeter:`atoms` in action. The material is lead
titanate, PbTiO\ :sub:`3`. The crystallographic literature places this
material in the tetragonal space group ``P 4 M M``. Let's suppose tha
the data were taken in fluorescence at the titanium K-edge. Since the
edge energy is around 5 KeV and the sample was very thick, the I\
:sub:`0` and self-absorption corrections are expected to be
significant. That titanium is the central atom is indicated by the
keyword ``core``. :demeter:`atoms` assumes the K-edge of the titanium
was probed because the atomic number of titanium is less than 57 and
the edge was not otherwise chosen with the ``edge`` keyword.  The I\ :sub:`0`
chamber was filled with 50% helium and 50% nitrogen by pressure.  This
is indicated by the ``nitrogen`` keyword. The size of the cluster to
be printed in :file:`feff.inp` is chosen with the ``rmax`` keyword. The
``rpath`` keyword is used to set the value of ``RMAX`` in the :file:`feff.inp`
file, which indicates the length of the longest path to be calculated.

::

    title PbTiO3 10K,a=3.885,c=4.139
    space P 4 m m
    a=3.885         c=4.139         nitrogen = 0.5
    rmax=5.0        rpath=4.2       core=ti
    atom
    * At      x    y    z      tag
      Pb     0.0  0.0  0.0
      Ti     0.5  0.5  0.5377
      O      0.5  0.5  0.1118 axial
      O      0.0  0.5  0.6174 planar

Note that CIF files can also be used as the input to :demeter:`atoms`
and will, in many cases, work just fine. The code that reads the CIF
files is rather incomplete and a bit buggy, though. Also,
:demeter:`demeter` will refuse to attempt to import data from a CIF
file that contains multiple occupancy for a crystallographic site.

.. bibliography:: ../artemis.bib
   :filter: author % "Nelmes"
   :list: bullet



The Feff input file
~~~~~~~~~~~~~~~~~~~

:demeter:`atoms` produces the output reproduced below. The absorption
and correction calculations are at the top of the file. All the
``CONTROL`` cards are set to 1 and the ``PRINT`` cards are set
to 0. This will run all four modules of :demeter:`feff` and produce
the default output files. Several other useful :demeter:`feff` cards
are printed but commented out by an asterisk (``*``). The unique
potential list is constructed in a simple fashion -- the core atom is
potential 0 and each different atomic species has a single
potential. The atom list is printed in the format required by
:demeter:`feff`. The atom list has two comment columns. The indexed
atomic symbol and radial distance are written by :demeter:`atoms` for
your use when reading :file:`feff.inp` and are ignored by
:demeter:`feff`.

:demeter:`feff` will run to completion using the input file generated
by :demeter:`atoms`. It is still likely that the user will want to
edit :file:`feff.inp`. Several assumptions are made by :demeter:`atoms` that
might not hold true. The assignment of unique potentials is made by a
simple algorithm and may not adequately reflect the physics of the
problem. The ``CONTROL`` cards are such that all four modules of
:demeter:`feff` will be run. The :demeter:`feff` user might want to
run the modules separately. Values for other cards have been assumed
and might not be desired. Other cards have been left out entirely.
Always check your :file:`feff.inp` file to be sure it is just what you
want.

::

     * This feff6 file was generated by Demeter 0.9.13
     * Demeter written by and copyright (c) Bruce Ravel, 2006-2012

     * --*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--
     * title = PbTiO3 10K,a=3.885,c=4.139
     * space = P 4 m m
     * a     =   3.88500    b    =   3.88500    c     =   4.13900
     * alpha =  90.00000    beta =  90.00000    gamma =  90.00000
     * rmax  =   5.00000    core  = ti
     * shift =   
     * atoms
     * # el.     x           y           z        tag
     *   Pb     0.00000     0.00000     0.00000   Pb        
     *   Ti     0.50000     0.50000     0.53770   Ti        
     *   O      0.50000     0.50000     0.11180   axial     
     *   O      0.00000     0.50000     0.61740   planar    
     * --*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--

     TITLE PbTiO3 10K,a=3.885,c=4.139

     HOLE      1   1.0   * FYI: (Ti K edge @ 4966 eV, second number is S0^2)
     *         mphase,mpath,mfeff,mchi
     CONTROL   1      1     1     1
     PRINT     1      0     0     0

     RMAX      4.2
     *NLEG      4

     POTENTIALS
      * ipot   Z      tag
         0     22     Ti        
         1     82     Pb        
         2     22     Ti        
         3     8      O         


     ATOMS                  * this list contains 94 atoms
     *   x          y          z     ipot tag           distance
        0.00000    0.00000    0.00000  0  Ti            0.00000
        0.00000    0.00000   -1.76280  3  axial.1       1.76280
        1.37355    1.37355    0.32988  3  planar.1      1.97031
       -1.37355    1.37355    0.32988  3  planar.1      1.97031
        1.37355   -1.37355    0.32988  3  planar.1      1.97031
       -1.37355   -1.37355    0.32988  3  planar.1      1.97031
        0.00000    0.00000    2.37620  3  axial.2       2.37620
        2.74711    0.00000    1.91346  1  Pb.1          3.34783
       -2.74711    0.00000    1.91346  1  Pb.1          3.34783
        0.00000    2.74711    1.91346  1  Pb.1          3.34783
        0.00000   -2.74711    1.91346  1  Pb.1          3.34783
        2.74711    0.00000   -2.22554  1  Pb.2          3.53548
       -2.74711    0.00000   -2.22554  1  Pb.2          3.53548
        0.00000    2.74711   -2.22554  1  Pb.2          3.53548
        0.00000   -2.74711   -2.22554  1  Pb.2          3.53548
        2.74711    2.74711    0.00000  2  Ti.1          3.88500
       -2.74711    2.74711    0.00000  2  Ti.1          3.88500
        2.74711   -2.74711    0.00000  2  Ti.1          3.88500
       -2.74711   -2.74711    0.00000  2  Ti.1          3.88500
        0.00000    0.00000    4.13900  2  Ti.2          4.13900
        0.00000    0.00000   -4.13900  2  Ti.2          4.13900
        2.74711    2.74711   -1.76280  3  axial.3       4.26623
       -2.74711    2.74711   -1.76280  3  axial.3       4.26623
        2.74711   -2.74711   -1.76280  3  axial.3       4.26623
       -2.74711   -2.74711   -1.76280  3  axial.3       4.26623
        1.37355    1.37355   -3.80912  3  planar.2      4.27583
       -1.37355    1.37355   -3.80912  3  planar.2      4.27583
        1.37355   -1.37355   -3.80912  3  planar.2      4.27583
       -1.37355   -1.37355   -3.80912  3  planar.2      4.27583
        4.12066    1.37355    0.32988  3  planar.3      4.35607
       -4.12066    1.37355    0.32988  3  planar.3      4.35607
        1.37355    4.12066    0.32988  3  planar.3      4.35607
       -1.37355    4.12066    0.32988  3  planar.3      4.35607
        4.12066   -1.37355    0.32988  3  planar.3      4.35607
       -4.12066   -1.37355    0.32988  3  planar.3      4.35607
        1.37355   -4.12066    0.32988  3  planar.3      4.35607
       -1.37355   -4.12066    0.32988  3  planar.3      4.35607
        2.74711    2.74711    2.37620  3  axial.4       4.55407
       -2.74711    2.74711    2.37620  3  axial.4       4.55407
        2.74711   -2.74711    2.37620  3  axial.4       4.55407
       -2.74711   -2.74711    2.37620  3  axial.4       4.55407
        1.37355    1.37355    4.46888  3  planar.4      4.87280
       -1.37355    1.37355    4.46888  3  planar.4      4.87280
        1.37355   -1.37355    4.46888  3  planar.4      4.87280
       -1.37355   -1.37355    4.46888  3  planar.4      4.87280

     END



Modifying the Feff input file
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

There are many reasons why you may want to edit the :file:`feff.inp` before
running :demeter:`feff`. Here are some examples.

**Change the absorber**
    Suppose your absorber is a very dilute dopant such that you do not
    expect, on the average, that another example of the dopant resides
    anywhere near the absorber. In that case, you would want to leave
    the atoms list untouched but change the atomic species of the
    absorber.
    
    In the example above, let's consider that the dilute absorber is
    Nb. To make it the absorber, we must modify the :file:`feff.inp`
    file like so:

    ::

         POTENTIALS
          * ipot   Z      tag
             0     41     Nb
             1     82     Pb        
             2     22     Ti        
             3     8      O         

         ATOMS                  * this list contains 94 atoms
         *   x          y          z     ipot tag           distance
            0.00000    0.00000    0.00000  0  Nb            0.00000

    Note that the labels (i.e. the instances of the string :quoted:`Nb`) are
    for the benefit of the human reader of the file and are also used
    by :demeter:`demeter` to provide some information for the
    user. The essential edit is to change the Z number of the absorber
    in the ``POTENTIALS`` list.

**Change a scatterer**
    Again, consider the situation of a Nb dopant in this crystal. With
    Ti as the absorber, we need to consider the possibility of a Nb atom
    in the third coordination shell. To do this, we must adit the
    ``POTENTIALS`` list to include Nb:

    ::

         POTENTIALS
          * ipot   Z      tag
             0     22     Ti
             1     82     Pb        
             2     22     Ti        
             3     8      O         
             4     41     Nb

    We must then replace one or more of the atoms in the third
    coordination shell with the new unique potential. Here is one
    example:

    ::

            2.74711    2.74711    0.00000  4  Nb            3.88500

    Again, the :quoted:`Nb` label is not used by :demeter:`feff` in
    any capacity, but is used by :demeter:`demeter`.

**Add an unique potential**
    You may choose to consider the possibility that the :demeter:`feff`
    calculation might be improved by allowing the axial and planar
    oxygen atoms to have their own unique potentials. This probably
    won't make much of a difference in this case, but in the case of an
    double bonded oxygenyl ligand (as in a uranyl or vanadyl species),
    it almost certainly will.
    
    First you must add a unique potential

    ::

         POTENTIALS
          * ipot   Z      tag
             0     22     Ti
             1     82     Pb        
             2     22     Ti        
             3     8      axial         
             4     8      planar

    Then you must modify the potential indeces in the to use the new
    potential index: ``ATOMS`` list:

    ::

            0.00000    0.00000   -1.76280  4  axial.1       1.76280
            1.37355    1.37355    0.32988  3  planar.1      1.97031
           -1.37355    1.37355    0.32988  3  planar.1      1.97031
            1.37355   -1.37355    0.32988  3  planar.1      1.97031
           -1.37355   -1.37355    0.32988  3  planar.1      1.97031
            0.00000    0.00000    2.37620  4  axial.2       2.37620


**Modify feff's parameters**
    :demeter:`feff` has lots of options that can be used to control
    the calculation of the muffin tin potentials, to alter the
    self-energy model, or to enable other features of the
    code. :demeter:`atoms` directly supports few of these additional
    features. Should you wish to use them, you must edit the
    :file:`feff.inp` accordingly.
