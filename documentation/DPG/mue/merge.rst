..
   Athena document is copyright 2016 Bruce Ravel and released under
   The Creative Commons Attribution-ShareAlike License
   http://creativecommons.org/licenses/by-sa/3.0/

Merging data
============

Merging data is one of the essential data processing steps. As with
every thing, :demeter:`demeter` tries to make merging as easy as
possible:

.. code-block:: perl

   my $merged = $data[0]->merge('e', @data); 

The first argument to the ``merge`` method specifies which spectrum is
merged: ``e`` means to merge |mu| (E), ``n`` means to merge normalized
|mu| (E), and ``k`` means to merge |chi| (k).

The caller is included in the merge.  Care is taken not to double
count the caller |nd| if the caller will be removed from the argument
list.  This is a convenience because, as shown above, you can simply
pass an entire array which also contains the caller.

The ``merge`` method returns a new Data object.

Both of the plot types below (``stddev`` and ``varience``) ignore many
settings of the Plot object in order to plot the data in the form in
which it was merged.  That is, :demeter:`demeter` does not in any way
propagate the uncertainty array through background removal or Fourier
transforms.  Trying to make one of these plots in a space other than
the merge space will not work.  Attempting to plot the standard
deviation or variance plots with a Data object that does not contain
merged data will return as error.

Plot merged data with standard deviation
----------------------------------------

.. code-block:: perl
   :linenos:

      #!/usr/bin/perl
      use Demeter;
      my @common = (energy => '$1', numerator => '$2', denominator => '$3', ln => 1,);
      my $prj = Demeter::Data::Prj -> new(file=>'U_DNA.prj');
      my @data = (
                  Demeter::Data -> new(file => 'examples/data/fe.060',
                                       name => "Fe scan 1",
                                       @common,
                                      ),
                  Demeter::Data -> new(file => 'examples/data/fe.061',
                                       name => "Fe scan 2",
                                       @common,
                                      ),
                  Demeter::Data -> new(file => 'examples/data/fe.062',
                                       name => "Fe scan 3",
                                       @common,
                                      ),
                 );
      my $merged = $data[0] -> merge('e', @data);
      $merged -> plot('stddev');


.. _fig-stddev:
.. figure:: ../../_images/merge_stddev.png
   :target: ../_images/merge_stddev.png
   :align: center

   This shows the merge of |mu| (E) of 3 iron foil scans along with
   the standard deviation array. 


The standard deviation has been added to and subtracted from the
|mu| (E) spectrum, so the red trace is an error margin for the
|mu| (E) spectrum. Note that this plot type can only be plotted using
a Data object which contains the data from a merge.  Trying to plot a
non-merged Data object in this way will return a warning without
plotting anything.


Plot merged data with variance
------------------------------

Change line 20 in the script above to this:
   
.. code-block:: perl

   $merged -> plot('variance'); 

.. _fig-variance:
.. figure:: ../../_images/merge_variance.png
   :target: ../_images/merge_variance.png
   :align: center


   This shows the merge of |mu| (E) of 3 iron foil scans along with
   the standard deviation array. 


The standard deviation has been scaled to plot with the |mu| (E)
spectrum, with the scaling factor is given in the legend.  This, then,
is a way of visualizing how the standard deviation is distributed
across the spectrum.  Note that this plot type can only be plotted
using a Data object which contains the data from a merge.  Trying to
plot a non-merged Data object in this way will return a warning
without plotting anything.

