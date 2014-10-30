<?php

$this->breadcrumbs = array(
	$model->label(2) => array('index'),
	GxHtml::valueEx($model),
);

$this->menu=array(
	array('label'=>Yii::t('app', 'List') . ' ' . $model->label(2), 'url'=>array('index')),
	array('label'=>Yii::t('app', 'Create') . ' ' . $model->label(), 'url'=>array('create')),
	array('label'=>Yii::t('app', 'Update') . ' ' . $model->label(), 'url'=>array('update', 'id' => $model->id)),
	array('label'=>Yii::t('app', 'Delete') . ' ' . $model->label(), 'url'=>'#', 'linkOptions' => array('submit' => array('delete', 'id' => $model->id), 'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>Yii::t('app', 'Manage') . ' ' . $model->label(2), 'url'=>array('admin')),
);
$this->beginWidget('zii.widgets.CPortlet', array(
	'htmlOptions'=>array(
		'class'=>''
	)
));
$this->widget('bootstrap.widgets.TbMenu', array(
	'type'=>'pills',
	'items'=>array(
		array('label'=>'Create', 'icon'=>'icon-plus', 'url'=>Yii::app()->controller->createUrl('create'), 'linkOptions'=>array()),
        array('label'=>'List', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('update&id='.$model->id), 'active'=>true, 'linkOptions'=>array()),
		array('label'=>'Manage', 'icon'=>'icon-search', 'url'=>Yii::app()->controller->createUrl('admin'),'linkOptions'=>array('class'=>'search-button')),
		array('label'=>'Export to PDF', 'icon'=>'icon-download', 'url'=>Yii::app()->controller->createUrl('GeneratePdf'), 'linkOptions'=>array('target'=>'_blank'), 'visible'=>true),
		array('label'=>'Export to Excel', 'icon'=>'icon-download', 'url'=>Yii::app()->controller->createUrl('GenerateExcel'), 'linkOptions'=>array('target'=>'_blank'), 'visible'=>true),
	),
));
$this->endWidget();
?>

<h1><?php echo Yii::t('app', 'View') . ' ' . GxHtml::encode($model->label()) . ' ' . GxHtml::encode(GxHtml::valueEx($model)); ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data' => $model,
	'attributes' => array(
'id',
'medical_act',
array(
			'name' => 'idservice0',
			'type' => 'raw',
			'value' => $model->idservice0 !== null ? GxHtml::link(GxHtml::encode(GxHtml::valueEx($model->idservice0)), array('service/view', 'id' => GxActiveRecord::extractPkValue($model->idservice0, true))) : null,
			),
array(
           'name'=>'type',
           'type'=>'raw',
           'value'=>(CHtml::encode($model->type)== 1)? "<span>Analyse</span>":"<span>Traitement</span>",
        ),

'transfer',
	),
)); ?>
<hr/>
<h2><?php echo GxHtml::encode($model->getRelationLabel('billingDetails')); ?></h2>
<hr/>
<?php


   $count=Yii::app()->db->createCommand('SELECT COUNT(*) FROM billing_details b,traitement t  where b.idmedical=t.id and t.id='.$_GET['id'])->queryScalar();
   $sql='SELECT b.id id, b.idinvoice Invoice, t.medical_act Medical_Act, t.type Type, b.quantity Quantity,
           case
           when type = 1 then "Analyse"
           when type = 2 then "Traitement"
           when type = 3 then "Lunette"
           else "Pharmacy"
           end Type,
           Price FROM billing_details b,traitement t  where b.idmedical=t.id and t.id='.$_GET['id'];
   
    $dataProvider=new CSqlDataProvider($sql, array(
    'totalItemCount'=>$count,
    'sort'=>array(
        'attributes'=>array(
             'id', 'Invoice', 'Medical_Act','Quantinty','Price','Type'
        ),
    ),
    'pagination'=>array(
        'pageSize'=>10,
    ),
));

 $this->widget('zii.widgets.grid.CGridView', array(
	'id' => 'billing-details-grid',
	'dataProvider' => $dataProvider,
	 'columns' => array(
		'id',
		'Medical_Act',
		'Type',
		'Invoice',
		'Quantity',
		'Price',
	),
)); ?>