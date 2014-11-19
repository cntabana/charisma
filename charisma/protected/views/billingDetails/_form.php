<?php
$this->pageTitle=Yii::app()->name . ' - Invoice Form';
$this->breadcrumbs=array(
	'-',
);
?>
<hr/>
<h2>Invoice No <?php echo $_GET['idinvoice'];?></h2>
<div class="form">

<?php 
//$model = new BillingDetails;

$form=$this->beginWidget('CActiveForm'); ?>
	
	<?php echo $form->errorSummary($model); ?>
    <div class="row">
    <?php $this->widget('ext.appendo.JAppendo',array(
        'id' => 'repeateEnum',        
        'model' => $model,
        'viewName' => 'enumerations',
        'labelDel' => 'Remove Row',
        'cssFile' => 'css/jquery.appendo2.css'
    )); ?>
    </div>
	<div class="row buttons">
		<?php echo CHtml::submitButton('Submit'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- form -->

<table width = '70%'>
<tr>
	<td>
<?php 

$this->widget('bootstrap.widgets.TbGridView',array(
	'id'=>'grid1',
	'dataProvider'=>$model->bill_invoice(),
        'type'=>'striped bordered condensed',
        'template'=>'{summary}{pager}{items}{pager}',
       
	'columns'=>array(
		'id',
		array( 
                 'class' => 'editable.EditableColumn',
                  'name' => 'idmedical',
                  'editable' => array(
                   'type'     => 'select',
                    'url'      => $this->createUrl('billingDetails/updateBooster'),
                   // 'source'=>Traitement::model()->findAllAttributes('id', 'medical_act'),
                    //'source'    => Traitement::model()->findAll(), 'id', 'medical_act',
                    'source'    => Editable::source(Traitement::model()->findAllByAttributes(array('type'=>$_REQUEST['type'],'transfer'=>1)), 'id', 'medical_act'),

                   
                  ),
          ),
		array( 
                 'class' => 'editable.EditableColumn',
                  'name' => 'quantity',
                  
                  'editable' => array(
                  	'mode'      => 'inline',
                   'type'     => 'text',
                    'url'      => $this->createUrl('billingDetails/updateBooster'),
                    'success' => 'js: function(data) {
                        $.fn.yiiGridView.update("grid1");
						$.fn.yiiGridView.update("grid2");
                }',
                   
                  ),
          ),
		array( 
                 'class' => 'editable.EditableColumn',
                  'name' => 'price',
            
                  'editable' => array(
                  	'mode'      => 'inline',
                   'type'     => 'text',
                    'url'      => $this->createUrl('billingDetails/updateBooster'),
                    'success' => 'js: function(data) {
						
						$.fn.yiiGridView.update("grid1");
						$.fn.yiiGridView.update("grid2");
                     
                }',
                   
                  ),
          ),
		array(
			    'class' => 'editable.EditableColumn',
				'name'=>'total',
				'header'=>'Total',
				'editable' => array(
				 'success' => 'js: function(data) {
                  
                }',
                ),
		),
		array(
			    'class' => 'editable.EditableColumn',
				'name'=>'companyPrice',
				'header'=>'85%',
				'editable' => array(
				 'success' => 'js: function(data) {
                  
                }',
                ),
		),
		array(
			     'class' => 'editable.EditableColumn',
				'name'=>'insurencePrice',
				'header'=>'15%',
				'editable' => array(
				 'success' => 'js: function(data) {
				 	
                }',
                ),
		),
	     
	),
)); ?>
	</td>
</tr>

<tr>
	<td colspan = 2 align='right'>
<?php 
$this->widget('bootstrap.widgets.TbGridView',array(
	'id'=>'grid2',
	'dataProvider'=>BillingDetails::model()->sum_invoice(),
        'type'=>'striped bordered condensed',
         'summaryText' => '', // 1st way
         'template' => '{items}{pager}', // 2nd way

	'columns'=>array(

		array(
				'name'=>'paid',
				'header'=>'You should pay this amount',
				'htmlOptions'=>array('style'=>'text-align: right;font-size:18px'),
		),
      
	),
)); ?>
	</td>
</tr>
</table>
