<?php

$this->breadcrumbs = array(
	$model->label(2) => array('index'),
	Yii::t('app', 'Manage'),
);

$this->menu = array(
		array('label'=>Yii::t('app', 'List') . ' ' . $model->label(2), 'url'=>array('index')),
		array('label'=>Yii::t('app', 'Create') . ' ' . $model->label(), 'url'=>array('create')),
	);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$.fn.yiiGridView.update('beneficaire-grid', {
		data: $(this).serialize()
	});
	return false;
});
");
$this->beginWidget('zii.widgets.CPortlet', array(
	'htmlOptions'=>array(
		'class'=>''
	)
));
$this->widget('bootstrap.widgets.TbMenu', array(
	'type'=>'pills',
	'items'=>array(
		array('label'=>'Create', 'icon'=>'icon-plus', 'url'=>Yii::app()->controller->createUrl('create'), 'visible'=>Yii::app()->user->groupe!=1 && Yii::app()->user->groupe!=2,'linkOptions'=>array()),
        array('label'=>'Manage', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('index'), 'visible'=>Yii::app()->user->groupe!=1 && Yii::app()->user->groupe!=2,'linkOptions'=>array()),
		array('label'=>'List', 'icon'=>'icon-search', 'url'=>Yii::app()->controller->createUrl('admin'),'active'=>true, 'linkOptions'=>array('class'=>'search-button')),
		array('label'=>'Export to PDF', 'icon'=>'icon-download', 'url'=>Yii::app()->controller->createUrl('GeneratePdf'), 'linkOptions'=>array('target'=>'_blank'), 'visible'=>true),
		array('label'=>'Export to Excel', 'icon'=>'icon-download', 'url'=>Yii::app()->controller->createUrl('GenerateExcel'), 'linkOptions'=>array('target'=>'_blank'), 'visible'=>true),
	),
));
$this->endWidget();
?>
<hr />
<h3><?php echo Yii::t('app', 'Manage') . ' ' . GxHtml::encode($model->label(2)); ?></h3>


<?php echo GxHtml::link(Yii::t('app', 'Advanced Search'), '#', array('class' => 'search-button')); ?>
<div class="search-form" style="display:none">
<?php $this->renderPartial('_search', array(
	'model' => $model,
)); ?>
</div><!-- search-form -->

<?php $this->widget('zii.widgets.grid.CGridView', array(
	'id' => 'beneficaire-grid',
	'dataProvider' => $model->search(),
	'filter' => $model,
	'columns' => array(
		'firstname',
		'middlename',
		'lastname',
		'dateofbirth',
		 array(
        'name'=>'sex',
        'value'=>'Beneficaire::getSex($data->sex)',
        'filter'=>CHtml::listData(Beneficaire::getSexs(), 'id', 'sex'),
        ),
        	array(
				'name'=>'idmember',
				'value'=>'GxHtml::valueEx($data->idmember0)',
				'filter'=>GxHtml::listDataEx(Members::model()->findAllAttributes(null, true)),
				),
		array(
        'name'=>'type',
        'value'=>'Beneficaire::getType($data->type)',
        'filter'=>CHtml::listData(Beneficaire::getTypes(), 'id', 'type'),
        ),
	
			array(
            'class'=>'CButtonColumn',
      'template' => '{view}',
      'buttons' => array(
            'view' => array(
          'label'=> 'View',
          'url'=>'Yii::app()->createUrl("beneficaire/view", array("id"=>$data->id))',
           'options'=>array(
           'class'=>'btn btn-small view'
          )
        ),  
                
          
      ),
        'htmlOptions'=>array('style'=>'width: 100px'),
           )
	),
)); ?>