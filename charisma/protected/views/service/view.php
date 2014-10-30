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
        array('label'=>'Update', 'icon'=>'icon-th-update', 'url'=>Yii::app()->controller->createUrl('Update&id='.$model->id), 'linkOptions'=>array()),
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
'service',
	),
)); ?>
<hr/>
<h4><?php echo GxHtml::encode($model->getRelationLabel('traitements')); ?></h4>
<hr/>

<?php 
$count=Yii::app()->db->createCommand('SELECT COUNT(*) FROM traitement  where idservice='.$_GET['id'])->queryScalar();
   $sql='SELECT id, medical_act Medical_Act, 
           case
           when type = 1 then "Analyse"
           when type = 2 then "Traitement"
           when type = 3 then "Lunette"
           else "Pharmacy"
           end Type,
           transfer Transfer FROM traitement   where idservice='.$_GET['id'];
   
    $dataProvider=new CSqlDataProvider($sql, array(
    'totalItemCount'=>$count,
    'sort'=>array(
        'attributes'=>array(
             'id', 'Medical_Act','Type','Transfer'
        ),
    ),
    'pagination'=>array(
        'pageSize'=>10,
    ),
));

$this->widget('zii.widgets.grid.CGridView', array(
	'id' => 'traitement-grid',
	'dataProvider' => $dataProvider,
		'columns' => array(
		'id',
		'Medical_Act',
		'Type',
		'Transfer',
			),
)); ?>