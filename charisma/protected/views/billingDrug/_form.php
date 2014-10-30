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
        'viewName' => 'enumerationsDrug',
        'labelDel' => 'Remove Row',
        'cssFile' => 'css/jquery.appendo2.css'
    )); ?>
    </div>
	<div class="row buttons">
		<?php echo CHtml::submitButton('Submit'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- form -->

<?php /*$this->widget('zii.widgets.grid.CGridView', array(
	'id' => 'billing-drug-grid',
	'dataProvider' => BillingDrug::model()->bill_invoice(),
	'columns' => array(
			array(
				'name'=>'idinvoice',
				'value'=>'GxHtml::valueEx($data->idinvoice0)',
				'filter'=>GxHtml::listDataEx(Invoice::model()->findAllAttributes(null, true)),
				),
		array(
				'name'=>'iddrug',
				'value'=>'GxHtml::valueEx($data->iddrug0)',
				'filter'=>GxHtml::listDataEx(Drugs::model()->findAllAttributes(null, true)),
				),
		'quantity',
		'iddrug0.cash',
			array(
			'class'=>'CButtonColumn',
			'template' =>'{update} {delete}',
			'buttons'=>array(
            'update'=>array(
                             'url'=>'Yii::app()->controller->createUrl("billingDrug/update",array("idinvoice"=>$data->idinvoice,"id"=>$data->id,"type"=>$_GET["type"]))',
							  'imageUrl'=>'../charisma/images/edit.gif',
			               ),
			 'delete'=>array(
                             'url'=>'Yii::app()->controller->createUrl("billingDrug/delete",array("idinvoice"=>$data->idinvoice,"id"=>$data->id))',
							  'imageUrl'=>'../charisma/images/delete.png',
			),         	
	                    ),
              ),
	),
)); 
*/
$this->widget('bootstrap.widgets.TbGridView',array(
	'id'=>'grid1',
	'dataProvider'=>BillingDrug::model()->bill_invoice(),
        'type'=>'striped bordered condensed',
        'template'=>'{summary}{pager}{items}{pager}',
       
	'columns'=>array(
		'id',
		array( 
                 'class' => 'editable.EditableColumn',
                  'name' => 'drug',
                  'editable' => array(
                   'type'     => 'select',
                    'url'      => $this->createUrl('billingDrugs/updateBooster'),
                   // 'source'=>Traitement::model()->findAllAttributes('id', 'medical_act'),
                    //'source'    => Traitement::model()->findAll(), 'id', 'medical_act',
                    'source'    => Editable::source(Drugs::model()->findAll(), 'id', 'drug'),

                   
                  ),
          ),
		array( 
                 'class' => 'editable.EditableColumn',
                  'name' => 'quantity',
                  
                  'editable' => array(
                  	'mode'      => 'inline',
                   'type'     => 'text',
                    'url'      => $this->createUrl('billingDrug/updateBooster'),
                    'success' => 'js: function(data) {
                        $.fn.yiiGridView.update("grid1");
						$.fn.yiiGridView.update("grid2");
                }',
                   
                  ),
          ),
		array( 
                 'class' => 'editable.EditableColumn',
                  'name' => 'cash',
            
                  'editable' => array(
                  'type'     => 'text',
                  'success' => 'js: function(data) {
					                    
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
	'dataProvider'=>BillingDrug::model()->sum_invoice(),
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